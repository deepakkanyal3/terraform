# module "aws-iam-identity-center" {
#   source = "../../../../../../modules/iam-identity-center"

#   # sso_groups = {
#   #   Admin : {
#   #     group_name        = "Admin"
#   #     group_description = "Admin IAM Identity Center Group"
#   #   },
#   #   Dev : {
#   #     group_name        = "Dev"
#   #     group_description = "Dev IAM Identity Center Group"
#   #   },
#   #   QA : {
#   #     group_name        = "QA"
#   #     group_description = "QA IAM Identity Center Group"
#   #   },
#   #   Audit : {
#   #     group_name        = "Audit"
#   #     group_description = "Audit IAM Identity Center Group"
#   #   },
#   # }

 
#   sso_users = {
#     deepak : {
#       group_membership = ["vipul_admin"]
#       user_name        = "deepak"
#       given_name       = "deepak kanyal"
#       family_name      = " "
#       email            = "deepak.kanyal@iopshub.com"
#     }
#   }

#   account_ids = ["239971792293"]
#   account_names = {
#     "239971792293" = "vipul"
#   }

#   permission_sets = {
#     admin_access = {
#       description          = "Provides full access to AWS services and resources",
#       session_duration     = "PT3H",
#       aws_managed_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
#       //inline_policy        = data.aws_iam_policy_document.restrictAccessInlinePolicy.json
#       tags                 = { ManagedBy = "Terraform" }
#     },
#     ViewOnlyAccess = {
#       description          = "This policy grants permissions to view resources and basic metadata across all AWS services",
#       session_duration     = "PT3H",
#       aws_managed_policies = ["arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"]
#       managed_policy_arn   = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"

#       permissions_boundary = {
#         managed_policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
#       }
#       tags = { ManagedBy = "Terraform" }
#     },
#     custom_access = {
#       description          = "This policy grants permissions to specific resource",
#       session_duration     = "PT3H",
#       aws_managed_policies = [
#         "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess",
#         "arn:aws:iam::aws:policy/AmazonS3FullAccess"
#       ]
#       inline_policy        = data.aws_iam_policy_document.restrictAccessInlinePolicy.json
#       //managed_policy_arn   = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"

#       # permissions_boundary = {
#       #   managed_policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
#       # }
#       tags = { ManagedBy = "Terraform" }
#     }
#   }

#   # account_assignments = {
#   #   Admin : {
#   #     principal_name = "Admin"
#   #     principal_type = "GROUP"
#   #     principal_idp  = "INTERNAL"
#   #     permission_sets = [
#   #       "custom_access"
#   #     ]
#   #     account_ids = [
#   #       local.account1_account_id,
#   #     ]
#   #   }
#   # }



# }

# #-----------------------------------------------------------------------------------------------------------------------
# # CREATE SOME IAM POLICIES TO ATTACH AS INLINE
# #-----------------------------------------------------------------------------------------------------------------------
# data "aws_iam_policy_document" "S3Access" {
#   statement {
#     sid = "1"

#     actions = [ 
#         "s3:GetObject",
#         "s3:ListBucket"
#         ]

#     resources = [
#       "arn:aws:s3:::iopshub-fileupload-api-prod",
#     ]
#   }
# }

# #-----------------------------------------------------------------------------------------------------------------------
# # CREATE SOME IAM POLICIES TO ATTACH AS MANAGED
# #-----------------------------------------------------------------------------------------------------------------------
# resource "aws_iam_policy" "S3Access" {
#   name   = "S3Access"
#   path   = "/"
#   policy = data.aws_iam_policy_document.S3Access.json
#   //tags   = module.this.tags
# }

# # Inline policy

# data "aws_iam_policy_document" "restrictAccessInlinePolicy" {
#   statement {
#     sid = "Restrict"
#     actions = [
#       "*",
#     ]
#     effect = "Deny"
#     resources = [
#       "*",
#     ]
#     condition {
#       test     = "NotIpAddress"
#       variable = "aws:SourceIp"
#       values = [
#         "0.0.0.0/0",
#       ]
#     }
#     condition {
#       test     = "Bool"
#       variable = "aws:ViaAWSService"
#       values = [
#         "false"
#       ]
#     }
#     condition {
#       test     = "StringNotLike"
#       variable = "aws:userAgent"
#       values = [
#         "*exec-env/CloudShell*"
#       ]
#     }
#   }
# }