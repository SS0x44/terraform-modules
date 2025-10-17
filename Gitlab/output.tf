output "gitlab_project_name" {
  value = var.create_project ? gitlab_project.cicd_gitlab[0].name : null
}

output "gitlab_group_id" {
  value = var.create_membership ? gitlab_group_membership.group_membership[0].group_id : null
}

output "gitlab_project_id" {
  value = var.create_project ? gitlab_project.cicd_gitlab[0].id : null
}
