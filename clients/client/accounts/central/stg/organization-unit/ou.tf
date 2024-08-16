# module "unit_prod" {
#   source = "../../../../../../modules/aws-organization/organizational-unit"

#   name      = "Prod"
#   parent_id = data.aws_organizations_organizational_units.ou.parent_id
# }

# module "unit_beta" {
#   source = "../../../../../../modules/aws-organization/organizational-unit"

#   name      = "Beta"
#   parent_id = data.aws_organizations_organizational_units.ou.parent_id
# }


# # Policy 1
# data "aws_iam_policy_document" "example" {
#   statement {
#     effect    = "Allow"
#     actions   = ["*"]
#     resources = ["*"]
#   }
# }

# module "access_all_service" {
#   source = "../../../../../../modules/aws-organization/organizations-policy"

#   content = data.aws_iam_policy_document.example.json
#   name    = "power_access"
#   description       = "admin access"
  
# }



# # Policy attach
# module "policy_attach" {
#   source = "../../../../../../modules/aws-organization/policy-attach"

#   policy_ids = module.access_all_service.aws_organizations_policy_id                                        //module.access_all_service.aws_organizations_policy_id
#   target_id  = module.unit_prod.aws_organizations_organizational_unit_id
# }