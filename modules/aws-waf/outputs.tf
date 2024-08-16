output "web_acl_arn" {
  description = "The ARN of the WAF WebACL"
  value       = aws_wafv2_web_acl.aws-waf-v2.arn
}

# output "allow_ip_set_arn" {
#   description = "The ARN of the WAF allow IP Set"
#   value       = aws_wafv2_ip_set.allow_ip_set.arn
# }

# output "block_ip_set_arn" {
#   description = "The ARN of the WAF block IP Set"
#   value       = aws_wafv2_ip_set.block_ip_set.arn
# }

# output "rule_group_arn1" {
#   description = "The ARN of the WAF rule group"
#   value       = aws_wafv2_rule_group.self_managed_rule_group1.arn
# }
# output "rule_group_arn2" {
#   description = "The ARN of the WAF rule group"
#   value       = aws_wafv2_rule_group.self_managed_rule_group2.arn
# }