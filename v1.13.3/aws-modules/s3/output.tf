output "bucket_id" {
  value = aws_s3_bucket.resource_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.resource_bucket.arn
}

output "versioning_status" {
  value = aws_s3_bucket_versioning.versioning.versioning_configuration[0].status
}

output "policy_json" {
  value = data.aws_iam_policy_document.bucket_policy.json
}

