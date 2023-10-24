##########
## SCP doesn't grant permissions but only sets boundaries, hence you cannot attache to it a policy document
## that has an Effect of type Allow if the root account has FullAWSAccess.
######
locals {
  org_units_ids_by_name = {
    for i in module.aws_org_units.organizational_units :
    i.name => i.id...
  }
}
output "org_units_by_ids" {
  value = local.org_units_ids_by_name
}

resource "aws_organizations_policy" "scp_basic_non_security_hub" {
  name        = "BasicNonSecurityHubSCP"
  content     = data.aws_iam_policy_document.basic_non_security_hub_policies_doc.json
  type        = "SERVICE_CONTROL_POLICY"
  description = "prevents users or roles in all accounts but security hub from running AWS Config operations that could disable AWS Config or alter its rules or triggers"
}

resource "aws_organizations_policy" "scp_basic_root" {
  name        = "BasicRootSCP"
  content     = data.aws_iam_policy_document.basic_root_policies_doc.json
  type        = "SERVICE_CONTROL_POLICY"
  description = "prevent sharing accounts outside of AWS Organization and leave organization"
}

resource "aws_organizations_policy" "scp_basic_sandbox" {
  name        = "BasicSandboxSCP"
  content     = data.aws_iam_policy_document.basic_sandbox_policies_doc.json
  type        = "SERVICE_CONTROL_POLICY"
  description = "Allow only t2.micro EC2 and allow get objects from S3 from anonymous identities"
}

resource "aws_organizations_policy_attachment" "all_non_security_hub_ous" {
  for_each  = toset(flatten(matchkeys(values(local.org_units_ids_by_name), keys(local.org_units_ids_by_name), [var.level_2_ous["i"], var.level_2_ous["sb"]])))
  policy_id = aws_organizations_policy.scp_basic_non_security_hub.id
  target_id = each.value
}

resource "aws_organizations_policy_attachment" "sandbox_ou" {
  for_each  = toset(local.org_units_ids_by_name[var.level_2_ous["sb"]])
  policy_id = aws_organizations_policy.scp_basic_sandbox.id
  target_id = each.value
}

resource "aws_organizations_policy_attachment" "root" {
  policy_id = aws_organizations_policy.scp_basic_root.id
  target_id = aws_organizations_organization.organization.roots[0].id
}

data "aws_iam_policy_document" "scp_require_micro_instances_t2any_t3any" {
  statement {
    sid    = "RequireMicroEC2InstanceTypeT2AnyT3Any"
    effect = "Deny"
    actions = [
      "ec2:RunInstances"
    ]

    resources = [
      "arn:aws:ec2:*:*:instance/*"
    ]
    condition {
      test     = "ForAnyValue:StringNotLike"
      variable = "ec2:InstanceType"
      values   = ["t2.*", "t3.*"]
    }
  }
}

data "aws_iam_policy_document" "basic_root_policies_doc" {
  statement {
    sid    = "PreventExternalSharing"
    effect = "Deny"
    actions = [
      "ram:CreateResourceShare",
      "ram:UpdateResourceShare"
    ]

    resources = [
      "*"
    ]
    condition {
      test     = "ForAnyValue:Bool"
      variable = "ram:RequestedAllowsExternalPrincipals"
      values   = ["true"]
    }
  }
  statement {
    sid    = "PreventLeaveOrganization"
    effect = "Deny"
    actions = [
      "organizations:LeaveOrganization"
    ]
    resources = ["*"]
  }

}

data "aws_iam_policy_document" "basic_non_security_hub_policies_doc" {
  statement {
    sid    = "PreventDisablingConfig"
    effect = "Deny"
    actions = [
      "config:DeleteConfigRule",
      "config:DeleteConfigurationRecorder",
      "config:DeleteDeliveryChannel",
      "config:StopConfigurationRecorder"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "basic_sandbox_policies_doc" {
  statement {
    sid    = "RequireMicroEC2InstanceTypeT2micro"
    effect = "Deny"
    actions = [
      "ec2:RunInstances"
    ]

    resources = [
      "arn:aws:ec2:*:*:instance/*"
    ]
    condition {
      test     = "ForAnyValue:StringNotEquals"
      variable = "ec2:InstanceType"
      values   = ["t2.micro"]
    }
  }
}

output "temp" {
  value = setsubtract(
    toset(
      flatten(
    values(local.org_units_ids_by_name))),
    toset(
      flatten(
        matchkeys(
  values(local.org_units_ids_by_name), keys(local.org_units_ids_by_name), [var.level_2_ous["s"]]))))
}
