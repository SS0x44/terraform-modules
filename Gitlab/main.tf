
resource "gitlab_user" "group_member" {
  count            = var.create_user ? 1 : 0
  name             = var.gitlab_username
  username         = var.gitlab_username
  password         = var.gitlab_password
  email            = var.gitlab_email
  is_admin         = var.is_admin
  projects_limit   = var.projects_limit
  can_create_group = var.can_create_group
  is_external      = var.is_external
  reset_password   = var.reset_password
}

resource "gitlab_group" "gitlab_group" {
  count            = var.create_group ? 1 : 0
  name             = var.gitlab_group_name
  path             = var.gitlab_group_path
  description      = var.gitlab_group_desc
  visibility_level = var.gitlab_group_vis_level
}

resource "gitlab_group_membership" "group_membership" {
  count         = var.create_membership ? 1 : 0
  group_id      = gitlab_group.gitlab_group[0].id
  user_id       = var.create_user ? gitlab_user.group_member[0].id : var.gitlab_user_id
  access_level  = var.gitlab_group_access_level
}

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
