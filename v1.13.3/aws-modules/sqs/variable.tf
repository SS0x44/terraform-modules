variable "queue_name" {
  type = list(string)
}

variable "delay_seconds" {
  type = list(number)
}

variable "max_message_size" {
  type = list(number)
}

variable "message_retention" {
  type = list(number)
}

variable "visibility_timeout" {
  type = list(number)
}

variable "receive_wait_time" {
  type = list(number)
}

locals {
  sqs_config_map = {
    for i in range(length(var.queue_name)) => var.name[i] => {
      delay_seconds              = var.delay_seconds[i]
      max_message_size           = var.max_message_size[i]
      message_retention_seconds  = var.message_retention[i]
      visibility_timeout_seconds = var.visibility_timeout[i]
      receive_wait_time_seconds  = var.receive_wait_time[i]
    }
  }
}
