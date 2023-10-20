module "aws_org_units" {
  source  = "../modules/aws_org_units"
  root_id = aws_organizations_organization.organization.roots[0].id

  organization = {
    units = [

      {
        name = var.level_1_ous["f"],
        key  = "${var.organization_name}-${var.level_1_ous["f"]}"
        units = [
          {
            name = var.level_2_ous["s"],
            key  = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["s"]}"
            accounts = [
              {
                name                              = var.accounts["SECURITY-HUB"].name
                key                               = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["s"]}-${var.level_2_ous["s"]}-${var.accounts["SECURITY-HUB"].name}"
                email                             = "${var.base_email}-fs-${var.accounts["SECURITY-HUB"].email_suffix}"
                allow_iam_users_access_to_billing = var.accounts["SECURITY-HUB"].iam_user_access_to_billing
                role_name                         = var.accounts["SECURITY-HUB"].role_name
                close_on_deletion                 = var.accounts["SECURITY-HUB"].close_on_deletion
              }
            ]
          },
          {
            name = var.level_2_ous["i"],
            key  = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["i"]}"
            units = [

              {
                name = "DEV",
                key  = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["i"]}-DEV",
                accounts = [
                  {
                    name                              = var.accounts["DEV-METAX7"].name
                    key                               = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["i"]}-DEV-${var.accounts["DEV-METAX7"].name}"
                    email                             = "${var.base_email}-fi-${var.accounts["DEV-METAX7"].email_suffix}"
                    allow_iam_users_access_to_billing = var.accounts["DEV-METAX7"].iam_user_access_to_billing
                    role_name                         = var.accounts["DEV-METAX7"].role_name
                    close_on_deletion                 = var.accounts["DEV-METAX7"].close_on_deletion
                  },
                  {
                    name                              = var.accounts["DEV-DMITRIKNN"].name
                    key                               = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["i"]}-DEV-${var.accounts["DEV-DMITRIKNN"].name}"
                    email                             = "${var.base_email}-fi-${var.accounts["DEV-DMITRIKNN"].email_suffix}"
                    allow_iam_users_access_to_billing = var.accounts["DEV-DMITRIKNN"].iam_user_access_to_billing
                    role_name                         = var.accounts["DEV-DMITRIKNN"].role_name
                    close_on_deletion                 = var.accounts["DEV-DMITRIKNN"].close_on_deletion
                  },
                  {
                    name                              = var.accounts["DEV-MY-BEST-CODE"].name
                    key                               = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["i"]}-DEV-${var.accounts["DEV-MY-BEST-CODE"].name}"
                    email                             = "${var.base_email}-fi-${var.accounts["DEV-MY-BEST-CODE"].email_suffix}"
                    allow_iam_users_access_to_billing = var.accounts["DEV-MY-BEST-CODE"].iam_user_access_to_billing
                    role_name                         = var.accounts["DEV-MY-BEST-CODE"].role_name
                    close_on_deletion                 = var.accounts["DEV-MY-BEST-CODE"].close_on_deletion
                  }
                ]
              },
              {
                name = "STAGING",
                key  = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["i"]}-STAGING",
                accounts = [
                  {
                    name                              = var.accounts["STAGING-METAX7"].name
                    key                               = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["i"]}-STAGING-${var.accounts["STAGING-METAX7"].name}"
                    email                             = "${var.base_email}-fi-${var.accounts["STAGING-METAX7"].email_suffix}"
                    allow_iam_users_access_to_billing = var.accounts["STAGING-METAX7"].iam_user_access_to_billing
                    role_name                         = var.accounts["STAGING-METAX7"].role_name
                    close_on_deletion                 = var.accounts["STAGING-METAX7"].close_on_deletion
                  },
                  {
                    name                              = var.accounts["STAGING-DMITRIKNN"].name
                    key                               = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["i"]}-STAGING-${var.accounts["STAGING-DMITRIKNN"].name}"
                    email                             = "${var.base_email}-fi-${var.accounts["STAGING-DMITRIKNN"].email_suffix}"
                    allow_iam_users_access_to_billing = var.accounts["STAGING-DMITRIKNN"].iam_user_access_to_billing
                    role_name                         = var.accounts["STAGING-DMITRIKNN"].role_name
                    close_on_deletion                 = var.accounts["STAGING-DMITRIKNN"].close_on_deletion
                  },
                  {
                    name                              = var.accounts["STAGING-MY-BEST-CODE"].name
                    key                               = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["i"]}-STAGING-${var.accounts["STAGING-MY-BEST-CODE"].name}"
                    email                             = "${var.base_email}-fi-${var.accounts["STAGING-MY-BEST-CODE"].email_suffix}"
                    allow_iam_users_access_to_billing = var.accounts["STAGING-MY-BEST-CODE"].iam_user_access_to_billing
                    role_name                         = var.accounts["STAGING-MY-BEST-CODE"].role_name
                    close_on_deletion                 = var.accounts["STAGING-MY-BEST-CODE"].close_on_deletion
                  }
                ]
              },
              {
                name = "PROD",
                key  = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["i"]}-PROD",
                accounts = [
                  {
                    name                              = var.accounts["PROD-METAX7"].name
                    key                               = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["i"]}-PROD-${var.accounts["PROD-METAX7"].name}"
                    email                             = "${var.base_email}-fi-${var.accounts["PROD-METAX7"].email_suffix}"
                    allow_iam_users_access_to_billing = var.accounts["PROD-METAX7"].iam_user_access_to_billing
                    role_name                         = var.accounts["PROD-METAX7"].role_name
                    close_on_deletion                 = var.accounts["PROD-METAX7"].close_on_deletion
                  },
                  {
                    name                              = var.accounts["PROD-DMITRIKNN"].name
                    key                               = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["i"]}-PROD-${var.accounts["PROD-DMITRIKNN"].name}"
                    email                             = "${var.base_email}-fi-${var.accounts["PROD-DMITRIKNN"].email_suffix}"
                    allow_iam_users_access_to_billing = var.accounts["PROD-DMITRIKNN"].iam_user_access_to_billing
                    role_name                         = var.accounts["PROD-DMITRIKNN"].role_name
                    close_on_deletion                 = var.accounts["PROD-DMITRIKNN"].close_on_deletion
                  },
                  {
                    name                              = var.accounts["PROD-MY-BEST-CODE"].name
                    key                               = "${var.organization_name}-${var.level_1_ous["f"]}-${var.level_2_ous["i"]}-PROD-${var.accounts["PROD-MY-BEST-CODE"].name}"
                    email                             = "${var.base_email}-fi-${var.accounts["PROD-MY-BEST-CODE"].email_suffix}"
                    allow_iam_users_access_to_billing = var.accounts["PROD-MY-BEST-CODE"].iam_user_access_to_billing
                    role_name                         = var.accounts["PROD-MY-BEST-CODE"].role_name
                    close_on_deletion                 = var.accounts["PROD-MY-BEST-CODE"].close_on_deletion
                  }
                ]
              },
            ]
          }
        ]
      },
      {
        name = var.level_1_ous["a"]
        key  = "${var.organization_name}-${var.level_1_ous["a"]}"
        units = [
          {
            name = var.level_2_ous["sb"],
            key  = "${var.organization_name}-${var.level_1_ous["a"]}-${var.level_2_ous["sb"]}"
            accounts = [
              {
                name                              = var.accounts["SANDBOX-METAX7"].name
                key                               = "${var.organization_name}-${var.level_1_ous["a"]}--${var.level_2_ous["sb"]}-${var.accounts["SANDBOX-METAX7"].name}"
                email                             = "${var.base_email}-asb-${var.accounts["SANDBOX-METAX7"].email_suffix}"
                allow_iam_users_access_to_billing = var.accounts["SANDBOX-METAX7"].iam_user_access_to_billing
                role_name                         = var.accounts["SANDBOX-METAX7"].role_name
                close_on_deletion                 = var.accounts["SANDBOX-METAX7"].close_on_deletion
              },
              {
                name                              = var.accounts["SANDBOX-DMITRIKNN"].name
                key                               = "${var.organization_name}-${var.level_1_ous["a"]}--${var.level_2_ous["sb"]}-${var.accounts["SANDBOX-DMITRIKNN"].name}"
                email                             = "${var.base_email}-asb-${var.accounts["SANDBOX-DMITRIKNN"].email_suffix}"
                allow_iam_users_access_to_billing = var.accounts["SANDBOX-DMITRIKNN"].iam_user_access_to_billing
                role_name                         = var.accounts["SANDBOX-DMITRIKNN"].role_name
                close_on_deletion                 = var.accounts["SANDBOX-DMITRIKNN"].close_on_deletion
              },
              {
                name                              = var.accounts["SANDBOX-MY-BEST-CODE"].name
                key                               = "${var.organization_name}-${var.level_1_ous["a"]}--${var.level_2_ous["sb"]}-${var.accounts["SANDBOX-MY-BEST-CODE"].name}"
                email                             = "${var.base_email}-asb-${var.accounts["SANDBOX-MY-BEST-CODE"].email_suffix}"
                allow_iam_users_access_to_billing = var.accounts["SANDBOX-MY-BEST-CODE"].iam_user_access_to_billing
                role_name                         = var.accounts["SANDBOX-MY-BEST-CODE"].role_name
                close_on_deletion                 = var.accounts["SANDBOX-MY-BEST-CODE"].close_on_deletion
              }
            ]
          }
        ]
      }
    ]
  }
}
output "all_accounts_details" {
  value = module.aws_org_units.accounts
}

