variable "iam_role_names" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "services" {
 type = list(string)
}

variable "effect" {
  type = string
}

variable "actions" {
  type = list(string)
}
