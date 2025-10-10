data "aws_iam_policy_document" "bucket_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.resource_bucket.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}
