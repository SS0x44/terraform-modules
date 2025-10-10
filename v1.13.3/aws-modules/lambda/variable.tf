# variables.tf
variable "aws_account_id" {
  type        = string
}

variable "region" {
  type        = string
}

variable "namespace" {
  type        = string
}

variable "env_tags" {
  type        = map(string)
}

variable "function_name" {
  type = string
}

variable "handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "timeout" {
  type = number
}

variable "memory_size" {
  type = number
}

variable "tags" {
  type = map(string)
}

variable "environment_variables" {
  type = map(string)
}
