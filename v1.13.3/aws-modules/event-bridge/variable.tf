# variables.tf
variable "aws_account_id" {
  type        = string
  description = "AWS account ID"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "deploy_color" {
  type        = string
  description = "Project namespace"
}

variable "env_tags" {
  type        = map(string)
}

variable "tags" {
  type        = map(string)
}

variable "lambda_sqs_mappings" {
  type = map(object({
    function_arn = string
    queue_arn    = string
  }))
}
