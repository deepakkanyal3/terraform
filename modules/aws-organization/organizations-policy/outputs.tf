# output "aws_organization_policy_id" {
#   description = "The unique identifier (ID) of the policy."
#   value       = aws_organizations_policy.this.id
# }

# output "aws_organization_policy_arn" {
#   description = "Amazon Resource Name (ARN) of the policy."
#   value       = aws_organizations_policy.this.arn
# }

# output "aws_organization_policy_tags_all" {
#   description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
#   value       = aws_organizations_policy.this.tags_all
# }

output "aws_organizations_policy_id_region" {
  description = "The ID of the SCP policy."
  value       = aws_organizations_policy.region[*].id
  sensitive   = true
}

output "aws_organizations_policy_arn" {
  description = "The ARN of the SCP policy."
  value       = aws_organizations_policy.region[*].arn
  sensitive   = true
}

output "aws_organizations_policy_tags_all" {
  description = "The tags associated with the SCP policy."
  value       = aws_organizations_policy.region[*].tags_all
}

output "aws_organizations_policy_id_encryption" {
  description = "The ID of the SCP policy."
  value       = aws_organizations_policy.encryption[*].id
  sensitive   = true
}

output "aws_organizations_policy_arn_encryption" {
  description = "The ARN of the SCP policy."
  value       = aws_organizations_policy.encryption[*].arn
  sensitive   = true
}

output "aws_organizations_policy_tags_all_encryption" {
  description = "The tags associated with the SCP policy."
  value       = aws_organizations_policy.encryption[*].tags_all
}

output "aws_organizations_policy_id_ec2" {
  description = "The ID of the SCP policy."
  value       = aws_organizations_policy.ec2[*].id
  sensitive   = true
}

output "aws_organizations_policy_arn_ec2" {
  description = "The ARN of the SCP policy."
  value       = aws_organizations_policy.ec2[*].arn
  sensitive   = true
}

output "aws_organizations_policy_tags_all_ec2" {
  description = "The tags associated with the SCP policy."
  value       = aws_organizations_policy.ec2[*].tags_all
}



