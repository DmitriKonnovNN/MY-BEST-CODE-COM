include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-s3-bucket.git//."
}

inputs = {
  bucket = "common-logs-metax7-sandbox-mbc"
  tags = {
    Owner       = "Dmitri Konnov"
    TargetUser = "Metax7"
    Environment = "sandbox"
    CreatedBy = "terragrunt"
  }
}
