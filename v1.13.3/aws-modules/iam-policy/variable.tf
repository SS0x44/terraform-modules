variable "sid" { 
type        = list(string) 
} 
variable "iam_policy_names" { 
type        = list(string) 
} 
variable "tags" { 
type        = map(string) 
}
variable "principal" { 
type        = string 
} 

variable "permission" { 
type        = string 
}
variable "service" { 
type        = string 
} 
variable "identifier" { 
type        = string 
} 
variable "actions" {
type        = list(string)
}
