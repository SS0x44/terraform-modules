output "pipeline_role_arn" {
  value = data.aws_iam_role.pipeline_role.arn
}
output "security_group_id" {
  value       = aws_security_group.ec2_sg.id
}
output "launch_template_id" {
  value       = aws_launch_template.launch_template.id
}
output "autoscaling_group_name" {
  value       = aws_autoscaling_group.ec2_asg_fleet.name
}
output "ssh_private_key" {
  value     = tls_private_key.ss0x44_key.private_key_pem
  sensitive = true
}



