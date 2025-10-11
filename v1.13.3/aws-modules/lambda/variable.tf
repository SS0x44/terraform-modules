# variables.tf
variable "function_names" {
  type = list(string)
}
variable "role_arn" {
  type        = string
}
variable "bucket_name" {
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

