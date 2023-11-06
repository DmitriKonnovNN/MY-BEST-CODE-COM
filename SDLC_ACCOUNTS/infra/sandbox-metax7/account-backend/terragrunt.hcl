include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = ".."
}

inputs = {
  bucket = "my-best-code-remote-state-metax7-sandbox"
  putin_khuylo = true
  tags = {
    Owner       = "Dmitri Konnov"
    TargetUser = "Metax7"
    Environment = "sandbox"
    CreatedBy = "terragrunt"
  }
}

