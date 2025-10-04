variable "account_id" {
  type = string
}

variable "region" {
  type = string
}

variable "namespace" {
  type = string
}

variable "env_short" {
  type = string
}

variable "ami_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "min_size" {
  type = string
}

variable "max_size" {
  type = string
}

variable "desired_capacity" {
  type = string
}

variable "asg_group_name" {
  type = string
}

variable "runner_sg" {
  type = string
}

variable "gl_runner_name" {
  type = string
}

variable "runner_token_01" {
  type      = string
  sensitive = true
}

variable "runner_token_02" {
  type      = string
  sensitive = true
}

variable "runner_token_03" {
  type      = string
  sensitive = true
}

variable "tf_version" {
  type = string
}

variable "tg_version" {
  type = string
}

variable "mvn_version" {
  type = string
}

variable "java_version" {
  type = string
}

variable "gitlab_url" {
  type = string
}