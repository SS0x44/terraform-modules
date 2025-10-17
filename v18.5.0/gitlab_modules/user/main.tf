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
