#tfsec:ignore:aws-s3-enable-bucket-encryption
#tfsec:ignore:aws-s3-encryption-customer-key
#tfsec:ignore:aws-s3-block-public-acls
#tfsec:ignore:aws-s3-block-public-policy
#tfsec:ignore:aws-s3-ignore-public-acls
#tfsec:ignore:aws-s3-no-public-buckets
#tfsec:ignore:aws-s3-enable-bucket-logging
module "s3-bucket" {
  source      = "../../../../../../modules/s3"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  consumer    = var.appname
  producer    = var.appname
  bucket      = var.appname
  # block_public_acls = false
  # block_public_policy = false
  # ignore_public_acls  = false
  # restrict_public_buckets = false
  versioning = {
    enabled    = true
    # mfa_delete = false
  }

}

data "aws_iam_policy_document" "s3_policy" {
  # Origin Access Identities
  statement {
    actions   = ["s3:GetObject", "s3:*"]
    resources = ["${module.s3-bucket.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = module.s3-bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_policy.json
}
#tfsec:ignore:aws-s3-enable-versioning
#tfsec:ignore:aws-s3-enable-bucket-encryption
#tfsec:ignore:aws-s3-encryption-customer-key
#tfsec:ignore:aws-s3-enable-bucket-logging
module "s3-bucket1" {
  source      = "../../../../../../modules/s3"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  consumer    = var.appname1
  producer    = var.appname1
  bucket      = var.appname1
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "s3_policy1" {
  # Origin Access Identities
    statement {
    effect = "Allow"
    actions   = ["s3:PutObject"]
    resources = [
      "${module.s3-bucket1.s3_bucket_arn}/*.jpg",
      "${module.s3-bucket1.s3_bucket_arn}/*.png",
      "${module.s3-bucket1.s3_bucket_arn}/*.jpeg",
      "${module.s3-bucket1.s3_bucket_arn}/*.pdf",
      "${module.s3-bucket1.s3_bucket_arn}/*.doc",
      "${module.s3-bucket1.s3_bucket_arn}/*.docx"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::718331536885:user/app-user"] 
    }
  }
  statement {
    effect = "Deny"
    actions   = ["s3:PutObject"]
    resources = [
      "${module.s3-bucket1.s3_bucket_arn}/*.jpg",
      "${module.s3-bucket1.s3_bucket_arn}/*.png",
      "${module.s3-bucket1.s3_bucket_arn}/*.jpeg",
      "${module.s3-bucket1.s3_bucket_arn}/*.pdf",
      "${module.s3-bucket1.s3_bucket_arn}/*.doc",
      "${module.s3-bucket1.s3_bucket_arn}/*.docx"
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"] 
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy7" {
  bucket = module.s3-bucket1.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_policy1.json
}

resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = module.s3-bucket1.s3_bucket_id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET","PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
    # max_age_seconds = null
  }
}

# data "aws_iam_policy_document" "s3_policy6" {
#   # Origin Access Identities
#   statement {
#     actions   = ["s3:GetObject"]
#     resources = ["${module.s3-bucket1.s3_bucket_arn}/*"]

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }
#   }
# }

# resource "aws_s3_bucket_policy" "bucket_policy6" {
#   bucket = module.s3-bucket1.s3_bucket_id
#   policy = data.aws_iam_policy_document.s3_policy6.json
# }



# module "s3-bucket2" {
#   source      = "../../../../../../modules/s3"
#   tags        = local.common_tags
#   environment = var.environment
#   account     = var.account
#   consumer    = var.appname2
#   producer    = var.appname2
#   bucket      = var.appname2
#   block_public_acls = true
#   block_public_policy = true
#   ignore_public_acls  = true
#   restrict_public_buckets = true
# }