#######################################################

locals {
  domain_name = "gromoinsure.in" # trimsuffix(data.aws_route53_zone.this.name, ".")
  subdomain   = "statichi-dev"
}

# locals {
#   domain_name7 = "gromoinsure.in" # trimsuffix(data.aws_route53_zone.this.name, ".")
#   subdomain7   = "statichi"
# }

#tfsec:ignore:aws-cloudfront-use-secure-tls-policy
#tfsec:ignore:aws-cloudfront-enable-logging
module "cloudfront" {
  source = "../../../../../../modules/cloudfront"

  aliases = ["${local.subdomain}.${local.domain_name}"]
  comment             = "dev-health-insurance"
  enabled             = true
  http_version        = "http2and3"
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false
  # default_root_object = "index.html"

    # When you enable additional metrics for a distribution, CloudFront sends up to 8 metrics to CloudWatch in the US East (N. Virginia) Region.
  # This rate is charged only once per month, per metric (up to 8 metrics per distribution).
  create_monitoring_subscription = false

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_one = "CloudFront OAI"
  }

  origin = {
    s3_one = {
      # domain_name = "${local.subdomain4}.${local.domain_name4}"
      domain_name = module.s3_one.s3_bucket_bucket_regional_domain_name
      # custom_origin_config = {
      #   http_port              = 80
      #   https_port             = 443
      #   origin_protocol_policy = "http-only"
      #   origin_ssl_protocols   = ["TLSv1.2"]
      # }
      s3_origin_config = {
        origin_access_identity = "s3_bucket_one" # key in `origin_access_identities`
        # cloudfront_access_identity_path = "origin-access-identity/cloudfront/E5IGQAA1QO48Z" # external OAI resource
      }
    }
  }

  default_cache_behavior = {
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    target_origin_id       = "s3_one"
    viewer_protocol_policy = "allow-all"
    use_forwarded_values = false
    allowed_methods        = ["GET", "HEAD"]
    # allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    # cached_methods         = ["GET", "HEAD"]
    compress               = true
    query_string           = true

  }

  viewer_certificate = {
    # acm_certificate_arn = module.acm-cert.acm_certificate_arn
    acm_certificate_arn = data.aws_acm_certificate.amazon_issued.arn
    ssl_support_method  = "sni-only"
  }
}

######
# ACM
######

# data "aws_route53_zone" "this1" {
#   name = local.domain_name1
# }

# Find a certificate issued by (not imported into) ACM
data "aws_acm_certificate" "amazon_issued" {
  domain      = "*.gromoinsure.in"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
  provider = aws.default-us-east-1
}

#############
# S3 buckets
#############
#tfsec:ignore:aws-s3-encryption-customer-key
#tfsec:ignore:aws-s3-enable-bucket-encryption
#tfsec:ignore:aws-s3-enable-bucket-logging
#tfsec:ignore:aws-s3-enable-versioning
module "s3_one" {
  source      = "../../../../../../modules/s3"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  consumer    = "User"
  producer    = "CDN"
  bucket      = "health-insurance"
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
  website = {
    index_document = "index.html"
  }
}

##########
# Route53
##########

# module "records1" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"

#   zone_id = data.aws_route53_zone.this1.zone_id

#   records = [
#     {
#       name = local.subdomain1
#       type = "CNAME"
#       alias = {
#         name    = module.cloudfront1.cloudfront_distribution_domain_name
#         zone_id = module.cloudfront1.cloudfront_distribution_hosted_zone_id
#       }
#     },
#   ]
# }

data "aws_iam_policy_document" "s3_policy" {
  # Origin Access Identities
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.s3_one.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = module.cloudfront.cloudfront_origin_access_identity_iam_arns
      # identifiers = ["*"]
    }
  }

  # Origin Access Controls
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.s3_one.s3_bucket_arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [module.cloudfront.cloudfront_distribution_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = module.s3_one.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_policy.json
}