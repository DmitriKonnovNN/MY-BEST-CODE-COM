terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
  }
  ####################################################################################################################
  # Definition of organization and workspace inside of Terraform Cloud, which is completely optional.
  # As the matter of fact we are provisioning master account infrastructure, there's no way to store the current
  # infrastructure state (CIS) in a S3 bucket due to not having any. That's why we're making use of Terraform Cloud
  # that provides a functionality of storing and locking a state for our master account. BTW, it also provides a
  # functionality of executing changes both remotely and locally.
  ####################################################################################################################
  cloud {
    organization = "MY_BEST_CODE"

    workspaces {
      name = "master-account"
    }
  }
  required_version = ">= 0.13.1"
}

provider "aws" {
  profile = var.master_aws_profile
  region  = var.master_account_default_region
  #####################################################################################################################
  # Default Tag(s) which are attached to each resource capable of having a tag. Default tag(s) can be overridden by a
  #  in-place tag definition;
  #####################################################################################################################
  default_tags {
    tags = {
      Environment  = var.default_tag_environment
      CreatedVia   = var.default_tag_created_by
      Organization = var.default_org_tag
    }
  }
}
