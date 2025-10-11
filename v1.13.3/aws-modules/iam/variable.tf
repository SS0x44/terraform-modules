# variables.tf
variable "aws_account_id" {
  type        = string
}

variable "region" {
  type        = string
}

variable "deploy_color" {
  type        = string
}

variable "env_tags" {
  type        = map(string)
}

"iam_role_names" { 
type        = list(string) 
} 

variable "inline_policies" { 
type        = list(string) 
} 

variable "tags" { 
type        = map(string) 
}
variable "service_pricipal" { 
type        = string 
} 

variable "permission_effect" { 
type        = string 
}
