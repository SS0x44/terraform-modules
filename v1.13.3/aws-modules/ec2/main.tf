#------------------------------
# 🔐 Security Group
#------------------------------
resource "aws_security_group" "gitlab_runner_sg" {
  name           = var.runner_sg
  description    = "Security group for Gitlab runner EC2 instances"
  vpc_id         = data.aws_vpc.select_exisitng_vpc.id
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
    Name        = var.runner_sg
  }
}
#------------------------------
# 🚀 Launch Template
#------------------------------
resource "aws_launch_template" "gitlab_runner_launch_template" {
  depends_on                    = [aws_security_group.gitlab_runner_sg, data.aws_ami.gitlab_runner_ami]
  image_id                      = data.aws_ami.gitlab_runner_ami.id
  instance_type                 = var.instance_type
  update_default_version        = true
  user_data                     = base64encode(file("${path.module}/scripts/user_data.sh"))
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.gitlab_runner_sg.id]
  }
  tag_specifications {
    resource_type              = "instance"
    tags                       = {
      Name                     = var.gl_runner_name
      Environment              = var.env_short
    }
  }
  lifecycle {
    create_before_destroy      = true
  }
}
#------------------------------
# 📈 Auto Scaling Group
#------------------------------
resource "aws_autoscaling_group" "gitlab_runner_asg" {
  depends_on            = [aws_launch_template.gitlab_runner_launch_template]
  name                  = var.asg_group_name
  max_size              = var.max_size
  min_size              = var.min_size
  desired_capacity      = var.desired_capacity
  vpc_zone_identifier   = data.aws_subnets.select_exisitng_vpc_subnets.ids
  launch_template {
    id                  = aws_launch_template.gitlab_runner_launch_template.id
    version             = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "gitlab-runner-instance"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
 }
}
#------------------------------
# 🔄 Instance Refresh
#------------------------------
resource "aws_autoscaling_group_instance_refresh" "gitlab_runner_refresh" {
  depends_on               = [aws_autoscaling_group.gitlab_runner_asg]
  autoscaling_group_name   = aws_autoscaling_group.gitlab_runner_asg.name
  strategy                 = "Rolling"
  triggers                 = ["launch_template"]
  preferences {
    min_healthy_percentage = 90
    instance_warmup        = 300
  }
}
