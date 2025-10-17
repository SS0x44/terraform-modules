variable "gitlab_token" {
  type        = string
  sensitive   = true
}
variable "gitlab_project_name" {
type = string
}

variable "gitlab_group_name" {
type = string
}

variable "gitlab_user_id" {
type        = number
}

variable "gitlab_project_desc" {
type = string
}

variable "gitlab_project_visibility_level" {
type = string
}
variable "initialize_with_readme" {
type = boolen
}

variable "gitlab_group_access_level" {
type        = number
}
variable "gitlab_group_desc" {
type = string
}

variable "gitlab_group_access_level" {
type = string
}

variable "project_env_var_key" {
type = string
}
variable "project_env_var_value" {
type = string
}
variable "env_var_is_protected" {
type = boolean
}
variable "env_var_is_masked" {
type = boolean
}
