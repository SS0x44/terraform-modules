locals {
  vpc_id = aws_vpc.vpc_aws[0].id
}

resource "aws_vpc" "vpc_aws" {
  count  = var.create_vpc ? 1 : 0
  cidr_block = var.cidr
  instance_tenancy = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics
  tags = merge({ "Name" = var.name }, var.tags, var.vpc_tags)
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_names)
  vpc_id = local.vpc_id
  availability_zone = var.azones[count.index]
  cidr_block = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  private_dns_hostname_type_on_launch = var.public_subnet_private_dns_hostname_type_on_launch
  tags = merge({ Name = var.public_subnet_names[count.index] }, var.tags, var.public_subnet_tags)
}

resource "aws_route_table" "public" {
  count = var.create_multiple_public_route_tables ? length(var.public_subnet_names) : 1
  vpc_id = local.vpc_id
  tags = merge({ "Name" = var.name }, var.tags, var.public_route_table_tags)
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_names)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = var.create_multiple_public_route_tables ? aws_route_table.public[count.index].id : aws_route_table.public[0].id
}

resource "aws_internet_gateway" "this" {
  count = var.create_vpc ? 1 : 0
  vpc_id = local.vpc_id
  tags = var.tags
}

resource "aws_route" "public_internet_gateway" {
  count = length(aws_route_table.public)
  route_table_id = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this[0].id
  timeouts { create = "5m" }
}

resource "aws_network_acl" "public" {
  vpc_id = local.vpc_id
  subnet_ids = aws_subnet.public[*].id
  tags = merge({ "Name" = "${var.name}-${var.public_subnet_suffix}" }, var.tags, var.public_acl_tags)
}

resource "aws_network_acl_rule" "public_inbound" {
  count = length(var.public_inbound_acl_rules)
  network_acl_id = aws_network_acl.public.id
  egress = false
  rule_number = var.public_inbound_acl_rules[count.index]["rule_number"]
  rule_action = var.public_inbound_acl_rules[count.index]["rule_action"]
  from_port = lookup(var.public_inbound_acl_rules[count.index], "from_port", null)
  to_port = lookup(var.public_inbound_acl_rules[count.index], "to_port", null)
  icmp_code = lookup(var.public_inbound_acl_rules[count.index], "icmp_code", null)
  icmp_type = lookup(var.public_inbound_acl_rules[count.index], "icmp_type", null)
  protocol = var.public_inbound_acl_rules[count.index]["protocol"]
  cidr_block = lookup(var.public_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.public_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "public_outbound" {
  count = length(var.public_outbound_acl_rules)
  network_acl_id = aws_network_acl.public.id
  egress = true
  rule_number = var.public_outbound_acl_rules[count.index]["rule_number"]
  rule_action = var.public_outbound_acl_rules[count.index]["rule_action"]
  from_port = lookup(var.public_outbound_acl_rules[count.index], "from_port", null)
  to_port = lookup(var.public_outbound_acl_rules[count.index], "to_port", null)
  icmp_code = lookup(var.public_outbound_acl_rules[count.index], "icmp_code", null)
  icmp_type = lookup(var.public_outbound_acl_rules[count.index], "icmp_type", null)
  protocol = var.public_outbound_acl_rules[count.index]["protocol"]
  cidr_block = lookup(var.public_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.public_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_names)
  availability_zone = var.azones[count.index]
  cidr_block = var.private_subnets[count.index]
  private_dns_hostname_type_on_launch = var.private_subnet_private_dns_hostname_type_on_launch
  vpc_id = local.vpc_id
  tags = merge({ Name = var.private_subnet_names[count.index] }, var.tags, var.private_subnet_tags)
}

resource "aws_route_table" "private" {
  count = length(var.private_subnet_names)
  vpc_id = local.vpc_id
  tags = merge({ "Name" = "${var.name}-${var.private_subnet_suffix}" }, var.tags, var.private_route_table_tags)
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_names)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = var.single_nat_gateway ? aws_route_table.private[0].id : aws_route_table.private[count.index].id
}

resource "aws_network_acl" "private" {
  vpc_id = local.vpc_id
  subnet_ids = aws_subnet.private[*].id
  tags = merge({ "Name" = "${var.name}-${var.private_subnet_suffix}" }, var.tags, var.private_acl_tags)
}

resource "aws_network_acl_rule" "private_inbound" {
  count = length(var.private_inbound_acl_rules)
  network_acl_id = aws_network_acl.private.id
  egress = false
  rule_number = var.private_inbound_acl_rules[count.index]["rule_number"]
  rule_action = var.private_inbound_acl_rules[count.index]["rule_action"]
  from_port = lookup(var.private_inbound_acl_rules[count.index], "from_port", null)
  to_port = lookup(var.private_inbound_acl_rules[count.index], "to_port", null)
  icmp_code = lookup(var.private_inbound_acl_rules[count.index], "icmp_code", null)
  icmp_type = lookup(var.private_inbound_acl_rules[count.index], "icmp_type", null)
  protocol = var.private_inbound_acl_rules[count.index]["protocol"]
  cidr_block = lookup(var.private_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.private_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "private_outbound" {
  count = length(var.private_outbound_acl_rules)
  network_acl_id = aws_network_acl.private.id
  egress = true
  rule_number = var.private_outbound_acl_rules[count.index]["rule_number"]
  rule_action = var.private_outbound_acl_rules[count
