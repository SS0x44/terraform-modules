# variables.tf
"iam_role_names" { 
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
