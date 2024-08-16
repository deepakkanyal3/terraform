

# Policy 1
data "aws_iam_policy_document" "example" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

module "access_all_service" {
  source = "../../../../../../modules/aws-organization/organizations-policy"

  content = data.aws_iam_policy_document.example.json
  name    = "gromo_admin_access"
  description       = "This policy provides admin access"

  tags = {
  "owner" = "gromo"
}
}

# # Policy attach
# module "policy_attach" {
#   source = "../../../../../../modules/aws-organization/policy-attach"

#   policy_ids = module.access_all_service.aws_organizations_policy_id_ec2
  
#   target_id  = "527374893274"
# }