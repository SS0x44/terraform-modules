# variables.tf
variable "function_names" {
  type = list(string)
}
variable "role_arn" {
  type        = string
}

variable "s3_key" {
 type = list(string)
}

variable "bucket_name" {
type = list(string)
}

variable "source" {
type = string
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

