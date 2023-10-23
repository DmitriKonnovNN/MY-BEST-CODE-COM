

resource "aws_identitystore_group_membership" "group_memberships" {
  identity_store_id = var.identity_store_id
  for_each = {
    for record in local.memberships :
    "${record.group_id}.${record.user_name}" => record
  }
  group_id  = each.value.group_id
  member_id = each.value.user_id
}


locals {

  memberships = flatten([
    for group in var.identity_store_groups : [
      for user in var.identity_store_users : {
        group_id   = group.group_id
        group_name = group.display_name
        user_id    = user.user_id
        user_name  = user.display_name
      }
    ]
  ])

}

output "memberships" {
  value = {
    for_each = {
      for record in local.memberships :
      "${record.group_id}.${record.user_name}" => record
  } }
}
