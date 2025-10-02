# variables.tf
variable "aws_account_id" {
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

variable "env_tags" {
  type        = map(string)
  description = "Environment-specific tags"
}
