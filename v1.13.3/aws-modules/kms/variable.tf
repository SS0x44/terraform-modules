# variables.tf
variable "kms_keys" {
  type = map(object({
    deletion_window_in_days = number
  }))
}

variable "kms_roles" {
  type = map(string)
}

variable "tags" {
  type = map(string)
}
