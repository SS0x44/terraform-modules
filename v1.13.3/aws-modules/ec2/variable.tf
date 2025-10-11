variable "ec_profile" {
  type = string
}
variable "region" {
  type = string
}

variable "vpc_name" {
type = string
}

variable "app_user" {
type = string
}
variable "pipeline_role" {
  type = string
}

variable "security_group" {
  type = string
}

variable "tags" {
  type = string
}

variable "ami_name" {
  type = string
}

variable "account_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "usr_data_tpl_path" {
  type = string
}

variable "ebs_optimized" {
  type = bool
}

variable "launch_tpl_imdsv2" {
   type    = string
}

variable "ebs_device_name" {
  type = string
}

variable "ebs_launch_tpl" {
  type = map(any)
}

variable "ec2_name" {
  type = string
}

variable "env_short" {
  type = string
}

variable "autoscale_group" {
  type = string
}
variable "tg_version" {
 type    = "string"
}
variable "mvn_version" {
 type    = "string"
}

variable "java_version" {
 type    = "string"
}
variable "tf_version" {
 type    = "string"
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}
