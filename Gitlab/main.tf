resource "gitlab_project" "cicd_gitlab" {
  name                   = var.gitlab_project_name
  description            = var.descrption
  visibility_level       = var.visibility_level
  initialize_with_readme = var.readme
}
