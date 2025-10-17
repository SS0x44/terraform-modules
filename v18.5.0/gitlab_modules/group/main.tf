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
