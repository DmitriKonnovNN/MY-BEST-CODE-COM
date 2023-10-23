
output "all_accounts_details" {
  value = module.aws_org_units.accounts
}
output "allacounts" {
  value = local.all_accounts
}

output "allacountids" {
  value = local.account_ids
}

output "account_groups" {
  value = local.account_groups
}

output "account_group_assignments" {
  value = local.account_group_assignments
}

output "first_digit_list_simulation" {
  value = local.first_digit_loss_simulation
}

output "identity_store_users" {
  value = module.identity_center_full_admins.identity_store_users
}

output "identity_store_groups" {
  value = module.identity_center_full_admins.identity_store_groups
}

output "sso_instance_arn" {
  value = module.identity_center_full_admins.sso_instance_arn
}

output "identity_store_id" {
  value = module.identity_center_full_admins.identity_store_id
}


locals {

  first_digit_loss_simulation = [for assignment in local.account_group_assignments : assignment.account]




  account_group_assignments = {
    for account_group in local.account_groups :
    "${account_group.permission_set_name}.${account_group.account}.${account_group.group}" => account_group
  }


  account_ids = {
    for i in module.aws_org_units.accounts :
    i.name => {
      id   = i.id
      name = i.name
    }
  }

  all_accounts = [
    for a in local.account_ids : a.name
  ]

  account_groups = flatten([
    for permission in var.junior_front_end_sso_permissions : [
      for account_group in setproduct(permission.aws_accounts == tolist(["ALL"]) ? local.all_accounts : permission.aws_accounts, permission.sso_groups) : {
        permission_set_name = permission.name
        account             = local.account_ids[account_group[0]].id
        group               = account_group[1]
      }
    ]
  ])
}
