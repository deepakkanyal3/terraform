module "iam_assumable_role_custom" {
  source = "../../../../../../modules/switch-role"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  providers = {
    aws.vpc_provider     = aws.brands-prod
    aws.second_provider  = aws
  }
}