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
}

variable "tags" {
  type        = map(string)
}
variable "sqs_queues" {
  type = list(object({
    name               = string
    delay_seconds      = number
    max_message_size   = number
    message_retention  = number
    visibility_timeout = number
    receive_wait_time  = number
  }))
}
