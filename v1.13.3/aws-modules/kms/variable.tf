# variables.tf
variable "kms_keys" {
  type = list(string)
}

variable "kms_roles" {
  type = list(string)
}

variable "in_days" { 
type = number
}

variable "tags" {
  type = map(string)
}
