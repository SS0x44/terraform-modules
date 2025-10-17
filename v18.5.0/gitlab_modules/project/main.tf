resource "gitlab_project" "cicd_gitlab" {
  count                  = var.create_project ? 1 : 0
  name                   = var.gitlab_project_name
  description            = var.gitlab_project_desc
  namespace_id           = gitlab_group.gitlab_group[0].id
  visibility_level       = var.gitlab_project_visibility_level
  initialize_with_readme = var.initialize_with_readme
}

resource "gitlab_project_variable" "cicd_vars" {
  count     = var.create_variable ? 1 : 0
  project   = gitlab_project.cicd_gitlab[0].id
  key       = var.project_env_var_key
  value     = var.project_env_var_value
  protected = var.env_var_is_protected
  masked    = var.env_var_is_masked
}
