resource "aws_s3_bucket" "resource_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.resource_bucket.id
  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_sse" {
  bucket = aws_s3_bucket.resource_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
resource "aws_s3_bucket_policy" "bucket_policy" {
  count  = var.attach_policy ? 1 : 0
  bucket = aws_s3_bucket.resource_bucket.id
  policy = data.aws_iam_policy_document.bucket_policy_document.json
}

resource "aws_s3_object" "bukcet_oject" {
  bucket  = aws_s3_bucket.resource_bucket.id
  key     = ""
}



