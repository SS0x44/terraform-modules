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
variable "function_names" {
  type = list(string)
}

variable "handlers" {
  type = list(string)
}

variable "runtimes" {
  type = list(string)
}

variable "timeout" {
  type = list(number)
}

variable "memory_size" {
  type = list(number)
}

variable "environment_variables_list" {
  type = list(map(string))
}
