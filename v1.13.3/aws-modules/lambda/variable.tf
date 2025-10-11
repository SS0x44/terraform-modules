# variables.tf
variable "aws_account_id" {
  type        = string
}

variable "region" {
  type        = string
}

variable "deploy_color" {
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

variable "timeouts" {
  type = list(number)
}

variable "memory_sizes" {
  type = list(number)
}

variable "environment_variables" {
  type = list(map(string))
}

variable "s3_key" {
 type = string
}

variable "bucket_name" {
type = string
}

variable "source" {
type = string
}
