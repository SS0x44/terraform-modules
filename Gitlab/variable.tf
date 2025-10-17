variable "gitlab_token" {
  type        = string
  sensitive   = true
}
variable "gitlab_project_name" {
type = string
}

variable "gitlab_project_descrption" {
type = string
}

variable "gitlab_project_visibility_level" {
type = string
}
variable "initialize_with_readme" {
type = boolen
}
