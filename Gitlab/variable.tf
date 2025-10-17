variable "gitlab_token" {
  type        = string
  sensitive   = true
}

variable "create_user" {
  type    = bool
  default = false
}

variable "create_group" {
  type    = bool
  default = true
}

variable "create_membership" {
  type    = bool
  default = true
}

variable "create_project" {
  type    = bool
  default = true
}

variable "create_variable" {
  type    = bool
  default = true
}

# User variables
variable "gitlab_username" { type = string }
variable "gitlab_password" { type = string }
variable "gitlab_email"    { type = string }
variable "is_admin"        { type = bool }
variable "projects_limit"  { type = number }
variable "can_create_group" { type = bool }
variable "is_external"     { type = bool }
variable "reset_password"  { type = bool }

# Group variables
variable "gitlab_group_name" { type = string }
variable "gitlab_group_path" { type = string }
variable "gitlab_group_desc" { type = string }
variable "gitlab_group_vis_level" { type = string }

# Membership variables
variable "gitlab_user_id" { type = number }
variable "gitlab_group_access_level" { type = number }

# Project variables
variable "gitlab_project_name" { type = string }
variable "gitlab_project_desc" { type = string }
variable "gitlab_project_visibility_level" { type = string }
variable "initialize_with_readme" { type = bool }

# CI/CD variable
variable "project_env_var_key" { type = string }
variable "project_env_var_value" { type = string }
variable "env_var_is_protected" { type = bool }
variable "env_var_is_masked"    { type = bool }
