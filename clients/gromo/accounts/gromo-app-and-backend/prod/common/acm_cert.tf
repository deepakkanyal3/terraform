# module "acm-cert" {
#   source      = "../../../../../../modules/acm-cert"
#   tags        = local.common_tags
#   environment = var.environment
#   account     = var.account
#   hosted_zone = var.hosted_zone
#   providers = {
#     aws.vpc_provider     = aws
#     aws.route53_provider = aws
#   }
# }

module "acm-indiasales" {
  source      = "../../../../../../modules/acm-cert"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  hosted_zone = "indiasales.club"
  providers = {
    aws.vpc_provider     = aws
    aws.route53_provider = aws
  }
}

module "acm-mygrid" {
  source      = "../../../../../../modules/acm-cert"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  hosted_zone = "mygrid.in"
  providers = {
    aws.vpc_provider     = aws
    aws.route53_provider = aws
  }
}
