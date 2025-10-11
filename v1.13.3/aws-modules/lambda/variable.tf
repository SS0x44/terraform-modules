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
  type = map(string)
}

variable "runtime" {
  type = map(string)
}

variable "timeout" {
  type = map(number)
}

variable "memory_size" {
 type =  map(number)
}

variable "tags" {
  type = map(string)
}

variable "environment_variables" {
  type = map(string)
}
