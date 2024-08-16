variable "AWS_REGION" {
  type        = string
  description = "Provide region in which to deploy TF code"
}

variable "credentials_profile_name" {
  type        = string
  description = "Name of the AWS credentials profile name to use."
}

variable "account" {
  type = string
}

variable "environment" {
  type = string
}

# data "aws_organizations_organization" "org" {}

# data "aws_organizations_organizational_units" "ou" {
#   parent_id = data.aws_organizations_organization.org.roots[0].id

# }

# data "aws_organizations_policies" "all_policies" {}

# data "aws_caller_identity" "current" {}

# data "aws_scp" "scp_policy" {
#   filter {
#     name   = "tag:Name"
#     values = ["gromo_region_restriction"]
#   }
# }