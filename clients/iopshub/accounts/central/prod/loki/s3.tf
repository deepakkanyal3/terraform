module "s3-bucket" {
  source      = "../../../../../../modules/s3"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  consumer    = var.appname
  producer    = var.appname
  bucket      = var.appname
}