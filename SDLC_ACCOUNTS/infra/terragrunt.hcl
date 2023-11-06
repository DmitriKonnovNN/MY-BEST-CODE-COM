remote_state {
  backend = "s3"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket  = "my-best-code-master-backend-state"
    region  = "us-west-1"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    encrypt = true
    dynamodb_table = "my_best_code_master_backend_state_locking"
    session_name = "terraform"
    profile = "MY_BEST_CODE_MASTER_ADMIN"
  }

}
generate "my_config" {
  path      = "_config.tf"
  if_exists = "overwrite"



  contents = <<EOF
#  terraform {
#  required_providers {
#    aws = {
#      source  = "hashicorp/aws"
#      version = "5.5.0"
#    }
#  }
#  required_version = ">= 0.13.1"
#}
provider "aws" {
  region  = var.target_region
  profile = var.master_aws_profile
  assume_role {
    role_arn = var.iam_role
    session_name = "terraform"
  }
}

variable "target_region" {}
variable "iam_role" {}
variable "master_aws_profile" {}

EOF
}

# Load Variables
terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()

    required_var_files = [
      find_in_parent_folders("common.tfvars"),
    ]
  }
}
