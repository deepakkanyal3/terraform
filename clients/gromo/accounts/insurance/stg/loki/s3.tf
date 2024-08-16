module "s3-bucket" {
  source      = "../../../../../../modules/s3"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  consumer    = var.appname
  producer    = var.appname
  bucket      = var.appname
  
  lifecycle_rule = [
  {
    id      = "gromo-insure-loki-stg"
    enabled = true
    prefix  = "loki*"

    tags = {
      rule      = "log"
      autoclean = "true"
    }

    expiration = {
      days = 60
    }

    noncurrent_version_expiration = {
      days = 60
    }
  }
  ]
}
