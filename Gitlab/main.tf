resource "gitlab_group" "gitlab_group" {
  name             = var.gitlab_group_name
  path             = var.gitlab_group_path
  description      = var.gitlab_group_desc
  visibility_level = var.gitlab_group_vis_level

resource "gitlab_group_membership" "group_member" {
  group_id        = gitlab_group.devops_team.id
  user_id         = var.gitlab_user_id
  access_level    = var.gitlab_group_access_level
}

resource "gitlab_project" "cicd_gitlab" {
  name                   = var.gitlab_project_name
  description            = var.gitlab_project_desc
  namespace_id           = gitlab_group.gitlab_group.id
  visibility_level       = var.gitlab_project_visibility_level
  initialize_with_readme = var.readme
}

resource "gitlab_project_variable" "cicd_vars" {
  project   = gitlab_project.cicd_gitlab.id
  key       = var.project_env_var_key
  value     = var.project_env_var_value
  protected = var.env_var_is_protected
  masked    = var.env_var_is_masked
}
