
# RESOURCE 01: Ec2  Profile
#---------------------------------------------------------
resource "aws_iam_instance_profile" "ec2_profile" {
name      = var.ec_profile
role      = var.pipeline_role
}

# 🔐 RESOURCE 02: Security Group
#---------------------------------------------------------

resource "aws_security_group" "ec2_sg" {
  name           = var.security_group 
  description    = "Security group for Gitlab runner EC2 instances"
  vpc_id         =  data.aws_vpc.select_exisitng_vpc.id
  ingress {      
    from_port    = 22
    to_port      = 22
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags          = {
    Name        =  var.tags
  }
}

# 🚀 RESOURCE 03: Launch Template
#---------------------------------------------------------

resource "aws_launch_template" "launch_template" {
  depends_on                    = [aws_security_group.ec2_sg, data.aws_ami.latest_golden_ami]
  image_id                      =  data.aws_ami.latest_golden_ami.id
  instance_type                 = var.instance_type
  update_default_version        = true
  user_data                     = var.usr_data_tpl_path 
  vpc_seciruty_group_ids        = [aws_security_group.ec2_sg.id]
  ebs_optimized                 = var.ebs_optimized
  metadata_options              = var.launch_tpl_imdsv2
  iam_instance_profile          { 
    name                        = aws_iam-profile.ec2_profile.name
  }
  block_device_mapping           {
   device                        = var.ebs_device_name
   ebs                           = var.ebs_launch_tpl
}
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ec_sg.id]
  }
  tag_specifications {
    resource_type              = "instance"
    tags                       = {
      Name                     = var.ec2_name
      Environment              = var.env_short
    }
  }
  lifecycle {
    create_before_destroy      = true
  }
  monitoring {
    enabled                    = true
  }
}

# 📈 RESOURCE 04: Auto Scaling Group
#---------------------------------------------------------

resource "aws_autoscaling_group" "ec2_asg_fleet" {
  depends_on            = [aws_launch_template.launch_template]
  name                  = var.autoscale_group
  max_size              = var.max_size
  min_size              = var.min_size
  desired_capacity      = var.desired_capacity
  vpc_zone_identifier   = data.aws_subnets.select_exisitng_vpc_subnets.ids
  launch_template {
    id                  = aws_launch_template.launch_template.id
    version             = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = var.ec2_name
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
 }
}

# 🔄  RESOURCE 05: Instance Refresh
#---------------------------------------------------------

resource "aws_autoscaling_group_instance_refresh" "ec2_asg_fleet_refresh" {
  depends_on               = [aws_autoscaling_group.ec2_asg_fleet]
  autoscaling_group_name   = aws_autoscaling_group.ec2_asg_fleet.name
  strategy                 = "Rolling"
  triggers                 = ["launch_template"]
  preferences {
    min_healthy_percentage = 90
    instance_warmup        = 300
  }
}




