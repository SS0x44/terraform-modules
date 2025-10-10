# Data Source 01 : VPC 
#----------------------------------------------------
data "aws_vpc" "select_existing_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name_tag]
  }
  filter {
    name   = "tag:Environment"
    values = [var.vpc_environment_tag]
  }
}

# Data Source 02 : VPC Subnets 
#------------------------------------------------------
data "aws_subnets" "select_existing_vpc_subnets" {
  depends_on = [data.aws_vpc.select_existing_vpc]
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.select_existing_vpc.id]
  }
}

# Data Source 03 : AMI 
#-----------------------------------------------------
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
