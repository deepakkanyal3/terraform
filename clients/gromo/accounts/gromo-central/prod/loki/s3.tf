#tfsec:ignore:aws-s3-enable-bucket-encryption
#tfsec:ignore:aws-s3-encryption-customer-key
#tfsec:ignore:aws-s3-block-public-acls
#tfsec:ignore:aws-s3-block-public-policy
#tfsec:ignore:aws-s3-ignore-public-acls
#tfsec:ignore:aws-s3-no-public-buckets
#tfsec:ignore:aws-s3-enable-bucket-logging
#tfsec:ignore:aws-s3-enable-versioning


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
    id      = "loki-central-prod"
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