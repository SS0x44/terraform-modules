# variables.tf
variable "topic_names" {
  type = list(string)
}
variable "tags" {
  type        = map(string)
}
