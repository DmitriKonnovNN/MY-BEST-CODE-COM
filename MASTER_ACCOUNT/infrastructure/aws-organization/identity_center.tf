module "identity_center_juiniors" {
  source          = "../modules/aws-identity-center"
  team_members    = var.junior_team_members
  accounts        = module.aws_org_units.accounts
  sso_permissions = var.junior_front_end_sso_permissions
}

module "identity_center_full_admins" {
  source          = "../modules/aws-identity-center"
  team_members    = var.full_admin_team_members
  accounts        = module.aws_org_units.accounts
  sso_permissions = var.full_admin_sso_permissions
}


#######################################################################################################################
#
# Because of for_each limitations discussed in here: https://github.com/hashicorp/terraform/issues/30838 
# Exclude the resourse "aws_identitystore_group_membership" "group_memberships" before identity store's groups and users
# are provisioned.  
#
#######################################################################################################################


module "memberships_junior" {
  depends_on            = [module.identity_center_juiniors]
  source                = "../modules/aws_identity_center_memberships"
  identity_store_groups = module.identity_center_juiniors.identity_store_groups
  identity_store_id     = module.identity_center_juiniors.identity_store_id
  identity_store_users  = module.identity_center_juiniors.identity_store_users
}

module "memberships_admins" {
  depends_on            = [module.identity_center_full_admins]
  source                = "../modules/aws_identity_center_memberships"
  identity_store_groups = module.identity_center_full_admins.identity_store_groups
  identity_store_id     = module.identity_center_full_admins.identity_store_id
  identity_store_users  = module.identity_center_full_admins.identity_store_users
}
