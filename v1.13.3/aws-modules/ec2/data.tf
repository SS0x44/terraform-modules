
data "aws_vpc" "select_exisitng_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name_tag]
  }
  filter {
    name   = "tag:Environment"
    values = [var.vpc_environmet_tag]
  }  
}

data "aws_subnets" "select_exisitng_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.select_exisitng_vpc.id]
  }
}

data "aws_ami" "latest_golden_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["<placeholder-company-golden-ami-pattern-*>"] 
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["<placeholder_for_aws_ami_account_id>"] 
}
