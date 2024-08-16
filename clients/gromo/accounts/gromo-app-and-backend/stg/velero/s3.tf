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
    id      = "gromo-app-backend-velero-stg"
    enabled = true
    prefix  = "velero*"

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