variable "master_name" {
  type = string
}
variable "master_account_id" {
  type = string
}
variable "master_account_alias" {
  type = string
}
variable "master_iam_admin_alias" {
  type = string
}
variable "organization_name" {
  type    = string
  default = "rental-cars"
}
variable "master_aws_profile" {
  type        = string
  sensitive   = true
  description = "AWS Access Credentials"
}
variable "master_account_default_region" {
  type        = string
  default     = "us-west-2"
  description = "default region of master account"
}
variable "default_tag_created_by" {
  type    = string
  default = "Terraform"
}
variable "default_tag_environment" {
  type    = string
  default = "Master-Account-General"
}
variable "default_org_tag" {
  type    = string
  default = "my-best-code"
}

variable "base_email" {
  type        = string
  description = "beginning of the email address that a +suffix@gmail.com is attached to"
  default     = "some-email"
}

variable "sso_portal" {
  type        = string
  description = "Single Sing On URL"
}

variable "level_1_ous" {
  type        = map(string)
  default     = { "f" = "foundational", "a" = "additional" }
  description = "level 1 of aws organizational units"
}

variable "level_2_ous" {
  type        = map(string)
  default     = { "s" = "security", "i" = "infrastructure", "sb" = "sandboxes" }
  description = "level 2 of aws organizational units"
}

variable "feature_set" {
  type        = string
  default     = "ALL"
  nullable    = false
  description = "The feature set of the organization. One of 'ALL' or 'CONSOLIDATED_BILLING'."
}

variable "aws_service_access_principals" {
  type = list(string)
  default = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "sso.amazonaws.com",
    "securityhub.amazonaws.com"
  ]
  nullable    = false
  description = "A list of AWS service principal names for which you want to enable integration with your organization."
}
variable "enabled_policy_types" {
  type        = list(string)
  default     = ["SERVICE_CONTROL_POLICY"]
  nullable    = false
  description = "A list of enabled organizations policy types"
}

variable "accounts" {
  type = map(object({
    name                       = string,
    email_suffix               = string,
    close_on_deletion          = bool,
    iam_user_access_to_billing = bool,
    role_name                  = string,
    s3_bucket_prefix           = string,
  }))
  default = {
    SANDBOX-METAX7 = {
      name                       = "SANDBOX-METAX7",
      email_suffix               = "metax7-sbx@gmail.com",
      close_on_deletion          = false,
      iam_user_access_to_billing = true,
      role_name                  = "OrganizationAccountAccessRole",
      s3_bucket_prefix           = "metax7sbx"
    },
    SANDBOX-DMITRIKNN = {
      name                       = "SANDBOX-DMITRIKNN",
      email_suffix               = "dmitriknn-sbx@gmail.com",
      close_on_deletion          = false,
      iam_user_access_to_billing = true,
      role_name                  = "OrganizationAccountAccessRole",
      s3_bucket_prefix           = "dmitriknnsbx"
    },
    SANDBOX-MY-BEST-CODE = {
      name                       = "SANDBOX-MY-BEST-CODE",
      email_suffix               = "mbc-sbx@gmail.com",
      close_on_deletion          = false,
      iam_user_access_to_billing = true,
      role_name                  = "OrganizationAccountAccessRole",
      s3_bucket_prefix           = "mbcsbx"
    },
    DEV-METAX7 = {
      name                       = "DEV-METAX7",
      email_suffix               = "metax7-dev@gmail.com",
      close_on_deletion          = false,
      iam_user_access_to_billing = true,
      role_name                  = "OrganizationAccountAccessRole",
      s3_bucket_prefix           = "metax7dev"
    },
    DEV-DMITRIKNN = {
      name                       = "DEV-DMITRIKNN",
      email_suffix               = "dmitriknn-dev@gmail.com",
      close_on_deletion          = false,
      iam_user_access_to_billing = true,
      role_name                  = "OrganizationAccountAccessRole",
      s3_bucket_prefix           = "dmitriknndev"
    },
    DEV-MY-BEST-CODE = {
      name                       = "DEV-MY-BEST-CODE",
      email_suffix               = "mbc-dev@gmail.com",
      close_on_deletion          = false,
      iam_user_access_to_billing = true,
      role_name                  = "OrganizationAccountAccessRole",
      s3_bucket_prefix           = "mybestcodedev"
    },
    PROD-METAX7 = {
      name                       = "PROD-METAX7",
      email_suffix               = "metax7-prod@gmail.com",
      close_on_deletion          = false,
      iam_user_access_to_billing = true,
      role_name                  = "OrganizationAccountAccessRole",
      s3_bucket_prefix           = "metax7prod"
    },
    PROD-DMITRIKNN = {
      name                       = "PROD-DMITRIKNN",
      email_suffix               = "dmitriknn-prod@gmail.com",
      close_on_deletion          = false,
      iam_user_access_to_billing = true,
      role_name                  = "OrganizationAccountAccessRole",
      s3_bucket_prefix           = "dmitriknnprod"
    },
    PROD-MY-BEST-CODE = {
      name                       = "PROD-MY-BEST-CODE",
      email_suffix               = "mbc-prod@gmail.com",
      close_on_deletion          = false,
      iam_user_access_to_billing = true,
      role_name                  = "OrganizationAccountAccessRole",
      s3_bucket_prefix           = "mybestcodeprod"
    },
    STAGING-METAX7 = {
      name                       = "STAGING-METAX7",
      email_suffix               = "metax7-staging@gmail.com",
      close_on_deletion          = false,
      iam_user_access_to_billing = true,
      role_name                  = "OrganizationAccountAccessRole",
      s3_bucket_prefix           = "metax7staging"
    },
    STAGING-DMITRIKNN = {
      name                       = "STAGING-DMITRIKNN",
      email_suffix               = "dmitriknn-staging@gmail.com",
      close_on_deletion          = false,
      iam_user_access_to_billing = true,
      role_name                  = "OrganizationAccountAccessRole",
      s3_bucket_prefix           = "dmitriknnstaging"
    },
    STAGING-MY-BEST-CODE = {
      name                       = "STAGING-MY-BEST-CODE",
      email_suffix               = "mbc-staging@gmail.com",
      close_on_deletion          = false,
      iam_user_access_to_billing = true,
      role_name                  = "OrganizationAccountAccessRole",
      s3_bucket_prefix           = "mybestcodestaging"
    },
    SECURITY-HUB = {
      name                       = "SECURITY-HUB",
      email_suffix               = "securityhub@gmail.com",
      close_on_deletion          = false,
      iam_user_access_to_billing = true,
      role_name                  = "OrganizationAccountAccessRole",
      s3_bucket_prefix           = "securityhub"
    },

  }
  description = "aws accounts deployed from master account"
}

variable "full_admin_sso_permissions" {
  type = list(object({
    name             = string
    description      = string
    session_duration = string
    managed_policies = list(string)
    aws_accounts     = list(string)
    sso_groups       = list(string)
  }))

  default = [
    {
      name             = "AdministratorAccess"
      description      = "Provides full access to AWS services and resources."
      session_duration = "PT4H"
      managed_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
      aws_accounts     = ["ALL"]
      sso_groups       = ["AdministratorGroup"]

    },
    {
      name             = "DatabaseAdministratorAccess"
      description      = "Grants full access permissions to AWS services and actions required to set up and configure AWS database services."
      session_duration = "PT4H"
      managed_policies = ["arn:aws:iam::aws:policy/job-function/DatabaseAdministrator"]
      aws_accounts     = ["ALL"]
      sso_groups       = ["DatabaseAdministratorGroup"]
    },
    {
      name             = "PowerUserAccess"
      description      = "Provides full access to AWS services and resources, but does not allow management of Users and groups."
      session_duration = "PT4H"
      managed_policies = ["arn:aws:iam::aws:policy/PowerUserAccess"]
      aws_accounts     = ["ALL"]
      sso_groups       = ["PowerUserGroup"]
    },
    {
      name             = "Billing"
      description      = "Grants permissions for billing and cost management. This includes viewing account usage and viewing and modifying budgets and payment methods."
      session_duration = "PT4H"
      managed_policies = ["arn:aws:iam::aws:policy/job-function/Billing"]
      aws_accounts     = ["ALL"]
      sso_groups       = ["BillingGroup"]
    },
    {
      name             = "ViewOnlyAccess"
      description      = "This policy grants permissions to view resources and basic metadata across all AWS services."
      session_duration = "PT4H"
      managed_policies = ["arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"]
      aws_accounts     = ["ALL"]
      sso_groups       = ["ViewOnlyGroup"]

    }

  ]
  description = "list of permission set properties for Identity Center (successor to SSO)"
  nullable    = false

}


variable "junior_front_end_sso_permissions" {
  type = list(object({
    name             = string
    description      = string
    session_duration = string
    managed_policies = list(string)
    aws_accounts     = list(string)
    sso_groups       = list(string)
  }))

  default = [
    {
      name             = "AdministratorAccessJFE"
      description      = "Provides full access to AWS services and resources."
      session_duration = "PT4H"
      managed_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
      aws_accounts     = []
      sso_groups       = ["AdministratorGroupJuniorFrontEnd"]

    },
    {
      name             = "DatabaseAdministratorAccessJFE"
      description      = "Grants full access permissions to AWS services and actions required to set up and configure AWS database services."
      session_duration = "PT4H"
      managed_policies = ["arn:aws:iam::aws:policy/job-function/DatabaseAdministrator"]
      aws_accounts     = ["SANDBOX-METAX7", "DEV-METAX7", "STAGING-METAX7"]
      sso_groups       = ["DatabaseAdministratorGroupJuniorFrontEnd"]
    },
    {
      name             = "PowerUserAccessJFE"
      description      = "Provides full access to AWS services and resources, but does not allow management of Users and groups."
      session_duration = "PT4H"
      managed_policies = ["arn:aws:iam::aws:policy/PowerUserAccess"]
      aws_accounts     = ["SANDBOX-METAX7", "DEV-METAX7", "STAGING-METAX7", "SANDBOX-MY-BEST-CODE"]
      sso_groups       = ["PowerUserGroupJuniorFrontEnd"]
    },
    {
      name             = "BillingJFE"
      description      = "Grants permissions for billing and cost management. This includes viewing account usage and viewing and modifying budgets and payment methods."
      session_duration = "PT4H"
      managed_policies = ["arn:aws:iam::aws:policy/job-function/Billing"]
      aws_accounts     = ["SANDBOX-METAX7", "DEV-METAX7", "STAGING-METAX7", "SANDBOX-MY-BEST-CODE"]
      sso_groups       = ["BillingGroupJuniorFrontEnd"]
    },
    {
      name             = "ViewOnlyAccessJFE"
      description      = "This policy grants permissions to view resources and basic metadata across all AWS services."
      session_duration = "PT4H"
      managed_policies = ["arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"]
      aws_accounts     = ["SANDBOX-METAX7", "DEV-METAX7", "STAGING-METAX7", "PROD-METAX7", "SANDBOX-DMITRIKNN", "SANDBOX-MY-BEST-CODE"]
      sso_groups       = ["ViewOnlyGroupJuniorFrontEnd"]

    }

  ]
  description = "list of permission set properties for Identity Center (successor to SSO)"
  nullable    = false

}

variable "junior_team_members" {
  type = map(object({
    display_name = string
    user_name    = string
    emails       = list(string)
    position     = list(string)
    expertise    = string
  }))
}

variable "full_admin_team_members" {
  type = map(object({
    display_name = string
    user_name    = string
    emails       = list(string)
    position     = list(string)
    expertise    = string
  }))
}

variable "budget_settings" {
  type = map(object({
    name         = string
    budget_type  = string
    limit_amount = string
    limit_unit   = string
    time_unit    = string
  }))
  default = {
    BUDGET_TOTAL = {
      name         = "monthly-budget"
      budget_type  = "COST"
      limit_amount = "2"
      limit_unit   = "USD"
      time_unit    = "MONTHLY"
    }
  }
}
variable "budget_notification_settings" {
  type = map(object({
    comparison_operator        = string
    threshold                  = number
    threshold_type             = string
    notification_type          = string
    subscriber_email_addresses = list(string)
  }))
  default = {
    DEF_NOTIFICATION = {
      comparison_operator        = "GREATER_THAN"
      threshold                  = 60
      threshold_type             = "PERCENTAGE"
      notification_type          = "FORECASTED"
      subscriber_email_addresses = ["test@example.com"]
    }
  }
}

