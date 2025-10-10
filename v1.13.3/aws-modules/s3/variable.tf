# variables.tf
variable "aws_account_id" {
  type        = string
  description = "AWS account ID"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "env_tags" {
  type        = map(string)
  description = "Environment-specific tags"
}
variable "bucket_name" {
  type = string
}

variable "log_bucket_name" {
  type = string
}

variable "enable_versioning" {
  type    = bool
  default = true
}

variable "enable_logging" {
  type    = bool
  default = true
}

variable "attach_policy" {
  type    = bool
  default = true
}
