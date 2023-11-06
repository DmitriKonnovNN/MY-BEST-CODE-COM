include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../MASTER_ACCOUNT/infrastructure/modules/aws-s3-dynamodb-backend//"
}

inputs = {
  full_bucket_name = "mbc-remote-state-metax7-sandbox"
  ddb_lock_full_name = "mbc-remote-state-lock-metax7-sandbox"
  tags = {
    Owner       = "Dmitri Konnov"
    TargetUser = "Metax7"
    Environment = "sandbox"
    CreatedBy = "terragrunt"
  }
}

