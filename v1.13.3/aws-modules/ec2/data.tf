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

# Data Source 03 : Role 
#-----------------------------------------------------
data "aws_ami" "latest_golden_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami_name]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = [var.account_id]
}

# Data Source 03 : AMI 
#-----------------------------------------------------
data "aws_iam_role" "pipeline_role" {
  name = var.pipeline_role
}
