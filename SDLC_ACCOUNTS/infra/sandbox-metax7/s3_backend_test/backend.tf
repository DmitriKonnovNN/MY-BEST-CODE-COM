terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }

  }
  ####################################################################################################################
  # bucket "${var.organization_name}-backend-state-${var.account_name}"
  # dynamodb_table"${var.organization_name}_${var.account_name}_state_locking"
  # When using SSO / Identity Center, which suits working procedure from local machine (not for CI/CD pipeline),
  # be aware, that backend configuration needs "profile" field to be declared. So consider using Terragrunt, if you want
  # to set backend fields dynamically. Another big issue is, that TF and TG don't understand profiles pointing to SSO
  # sessions in config files, that's why duplicate in profiles sso_start_url and sso_region fields just as in session.
  # Furthermore, should you have already initialized backend before introducing sso, use -reconfigure flag with terraform init
  # command. Run command down below to acquire new session token, in case the old one's expired.
  # aws sso login --profile SANDBOX-ADMIN
  ####################################################################################################################

  backend "s3" {
    bucket  = "my-best-code-test-backend-of-backends"
    key     = "tf-infra/terraform.tfstate"
    region  = "us-west-1"
    encrypt = true
    profile = "MY_BEST_CODE_MASTER_ADMIN"
  }
  required_version = ">= 0.13.1"
}

provider "aws" {
  profile = "MY_BEST_CODE_MASTER_ADMIN"
  region  = "us-west-1"
  #####################################################################################################################
  # Down below we're assuming a cross account organization role "OrganizationAccountAccessRole" which was created whilst
  # setting up the AWS Organization. This gives the admin an opportunity to create resources by using his/her identity.
  #####################################################################################################################
  assume_role {
    role_arn     = "arn:aws:iam::021427789578:role/OrganizationAccountAccessRole"
    session_name = "terraform"
  }
  #####################################################################################################################
  # Default Tag(s) which are attached to each resource capable of having a tag. Default tag(s) can be overridden by a
  #  in-place tag definition;
  #####################################################################################################################

}


