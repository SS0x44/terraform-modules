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

variable "tags" {
  type        = map(string)
}

variable "lambda_sqs_mappings" {
  type = map(object({
    function_arn = string
    queue_arn    = string
  }))
}
