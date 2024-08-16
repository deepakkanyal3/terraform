module "acm-cert" {
  source      = "../../../../../../modules/acm-cert"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  hosted_zone = var.hosted_zone
  providers = {
    aws.vpc_provider     = aws
    aws.route53_provider = aws
  } 
}

