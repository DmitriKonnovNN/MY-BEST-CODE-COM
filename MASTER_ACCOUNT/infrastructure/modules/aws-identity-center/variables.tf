variable "sso_permissions" {
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
      aws_accounts     = ["SANDBOX"]
      sso_groups       = ["AdministratorGroup"]

    },
    {
      name             = "DatabaseAdministratorAccess"
      description      = "Grants full access permissions to AWS services and actions required to set up and configure AWS database services."
      session_duration = "PT4H"
      managed_policies = ["arn:aws:iam::aws:policy/job-function/DatabaseAdministrator"]
      aws_accounts     = ["SANDBOX"]
      sso_groups       = ["DatabaseAdministratorGroup"]
    },
    {
      name             = "PowerUserAccess"
      description      = "Provides full access to AWS services and resources, but does not allow management of Users and groups."
      session_duration = "PT4H"
      managed_policies = ["arn:aws:iam::aws:policy/PowerUserAccess"]
      aws_accounts     = ["SANDBOX"]
      sso_groups       = ["PowerUserGroup"]
    },
    {
      name             = "Billing"
      description      = "Grants permissions for billing and cost management. This includes viewing account usage and viewing and modifying budgets and payment methods."
      session_duration = "PT4H"
      managed_policies = ["arn:aws:iam::aws:policy/job-function/Billing"]
      aws_accounts     = ["SANDBOX"]
      sso_groups       = ["BillingGroup"]
    },
    {
      name             = "ViewOnlyAccess"
      description      = "This policy grants permissions to view resources and basic metadata across all AWS services."
      session_duration = "PT4H"
      managed_policies = ["arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"]
      aws_accounts     = ["SANDBOX"]
      sso_groups       = ["ViewOnlyGroup"]

    }

  ]
  description = "list of permission set properties for Identity Center (successor to SSO)"
  nullable    = false

}

variable "accounts" {
  type = map(object({
    id        = string
    arn       = string
    name      = string
    email     = string
    parent_id = string
  }))
}

variable "team_members" {
  type = map(object({
    display_name = string
    user_name    = string
    emails       = list(string)
  }))
  #  validation {
  #    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.team_members.emails[0]))
  #    error_message = "invalid email"
  #  }
}
