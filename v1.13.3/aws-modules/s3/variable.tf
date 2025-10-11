# variables.tf
variable "bucket_name" {
  type = string
}

variable "enable_versioning" {
  type    = bool
  default = true
}

variable "attach_policy" {
  type    = bool
  default = true
}
