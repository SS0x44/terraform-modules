# variables.tf
variable "sns_topic_arns" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "alarm_names" {
  type = list(string)
}

variable "namespaces" {
  type = list(string)
}

variable "metric_names" {
  type = list(string)
}

variable "statistics" {
  type = list(string)
}

variable "periods" {
  type = list(number)
}

variable "evaluation_periods" {
  type = list(number)
}

variable "thresholds" {
  type = list(number)
}

variable "comparison_operators" {
  type = string
}

variable "dimensions" {
  type = map(string)
}

variable "alarm_description" {
  type = string
}
