# variables.tf
variable "aws_account_id" {
  type        = string
}

variable "region" {
  type        = string
}

variable "depoy_color" {
  type        = string

}

variable "env_tags" {
  type        = map(string)
}

variable "tags" {
 type      = map(string)
}

variable "retention_in_days" {
 typr = string
}
