# Generate config.tf file with provider configuration
generate "my_config" {
  path      = "_config.tf"
  if_exists = "overwrite"



  contents = <<EOF
  terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
  }
  cloud {
    organization = "my-best-code"

    workspaces {
      name = "var.tf_cloud_workspace"
    }
  }
  required_version = ">= 0.13.1"
}
provider "aws" {
  region  = var.master_account_default_region
  profile = var.master_aws_profile
  assume_role {
    role_arn = var.iam_role
    session_name = "terraform"
  }
}

variable "master_account_default_region" {}
variable "iam_role" {}
variable "master_aws_profile" {}
variable "f_cloud_workspace" {}
  
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
