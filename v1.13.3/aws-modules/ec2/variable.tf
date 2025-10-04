# variables.tf
variable "account_id" {
  type        = string
  description = "AWS account ID"
}
variable "region" {
  type        = string
  description = "AWS region"
}
variable "namespace" {
  type        = string
  description = "Project namespace"
}
variable "env_short" {
  type        = map(string)
  description = "Environment-specific tags"
}
variable "ami_name" {
  description = "AMI ID for EC2 instances"
  type        = string
}
variable "instance_type" {
  description = "EC2 instance type"
}
variable "min_size" {
  description = "Minimum number of instances in ASG"
}
variable "max_size" {
  description = "Maximum number of instances in ASG"
}
variable "desired_capacity" {
  description = "Desired number of instances in ASG"
}
variable "asg_group_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}
variable "runner_sg" {
  description = "Name of the security group for GitLab Runner"
  type        = string
}
variable "gl_runner_name" {
  description = "Tag name for GitLab Runner EC2 instance"
  type        = string
}


