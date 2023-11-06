#######################################################################################################################
# S3 Buckets to save and lock terraform state for each account except for master. (The latter one is managed by TF Cloud)
#######################################################################################################################
resource "aws_s3_bucket" "state_bucket" {
  bucket   = lower("${var.full_bucket_name}")

}
#######################################################################################################################
# Blocks any public access to buckets containing states explicitly.
#######################################################################################################################
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.state_bucket.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets

}

#######################################################################################################################
# Having versioning gives an opportunity to keep track of state's versions. However the versioning is attended by a
# the following concern: bucket's size gets bigger, because all versions are saved entirely - no incremental versioning.
# Once enabled, versioning cannot be disabled, unless the bucket is deleted completely.
#######################################################################################################################
resource "aws_s3_bucket_versioning" "buckets_version" {
  bucket   = aws_s3_bucket.state_bucket.id
  versioning_configuration {
    status = var.bucket_versioning
  }
}

#######################################################################################################################
# Encryption at rest.
#######################################################################################################################
resource "aws_s3_bucket_server_side_encryption_configuration" "buckets_encryption" {
  bucket   = aws_s3_bucket.state_bucket.id


  rule {
    bucket_key_enabled = var.bucket_key_enabled
    apply_server_side_encryption_by_default {
      sse_algorithm = var.bucket_sse_alg
    }
  }
}

output "backend_bucket_id" {
  value = aws_s3_bucket.state_bucket.id
}

output "backend_bucket_arn" {
  value = aws_s3_bucket.state_bucket.arn
}

output "backend_bucket_sse_config" {
  value = aws_s3_bucket.state_bucket.server_side_encryption_configuration
}