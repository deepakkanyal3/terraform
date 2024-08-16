#tfsec:ignore:aws-s3-enable-bucket-encryption
#tfsec:ignore:aws-s3-encryption-customer-key
#tfsec:ignore:aws-s3-block-public-acls
#tfsec:ignore:aws-s3-enable-bucket-logging
#tfsec:ignore:aws-s3-enable-versioning
#tfsec:ignore:aws-s3-block-public-policy
#tfsec:ignore:aws-s3-ignore-public-acls
#tfsec:ignore:aws-s3-no-public-buckets
module "s3-bucket" {
  source      = "../../../../../../modules/s3"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  consumer    = var.appname
  producer    = var.appname
  bucket      = var.appname
}