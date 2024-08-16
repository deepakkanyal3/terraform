########################################################

locals {
  domain_name4 = "gromoinsure.co.in" # trimsuffix(data.aws_route53_zone.this.name, ".")
  subdomain4   = "www"
}

locals {
  domain_name6 = "gromoinsure.in" # trimsuffix(data.aws_route53_zone.this.name, ".")
  subdomain6  = "www"
}
#tfsec:ignore:aws-cloudfront-enable-logging
#tfsec:ignore:aws-s3-block-public-acls
module "cloudfront4" {
  source = "../../../../../../modules/cloudfront"

  aliases = ["${local.subdomain6}.${local.domain_name6}"]
  comment             = "gromoinsure production"
  enabled             = true
  http_version        = "http2and3"
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false
  default_root_object = "index.html"

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
      domain_name = module.s3_one4.s3_bucket_website_endpoint
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

  default_cache_behavior = {
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    target_origin_id       = "s3_one"
    viewer_protocol_policy = "redirect-to-https"
    use_forwarded_values = false
    # allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    # cached_methods         = ["OPTIONS"]
    compress               = true
    query_string           = true

  }

  viewer_certificate = {
    # acm_certificate_arn = module.acm-cert.acm_certificate_arn
    acm_certificate_arn = data.aws_acm_certificate.amazon_issued6.arn
    ssl_support_method  = "sni-only"
  }
}

######
# ACM
######

data "aws_route53_zone" "this4" {
  name = local.domain_name4
}

data "aws_acm_certificate" "amazon_issued6" {
  domain      = "*.gromoinsure.in"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
  provider = aws.default-us-east-1
}

module "acm-cert" {
  source      = "../../../../../../modules/acm-cert"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  hosted_zone = data.aws_route53_zone.this4.name
  providers = {
    aws.vpc_provider     = aws.default-us-east-1
    aws.route53_provider = aws
  }
}

#############
# S3 buckets
#############
#tfsec:ignore:aws-aws-s3-block-public-acls
#tfsec:ignore:aws-s3-block-public-policy
#tfsec:ignore:aws-s3-ignore-public-acls
#tfsec:ignore:aws-s3-no-public-buckets
#tfsec:ignore:aws-s3-enable-versioning
#tfsec:ignore:aws-s3-enable-bucket-encryption
module "s3_one4" {
  source      = "../../../../../../modules/s3"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  consumer    = "User"
  producer    = "CDN"
  bucket      = "www.gromoinsure.co.in"
  # block_public_acls = true
  # block_public_policy = true
  # ignore_public_acls  = true
  # restrict_public_buckets = true
  # versioning = {
  #   status     = true
  # }
  website = {
    index_document = "index.html"
  }
}

##########
# Route53
##########

# module "records4" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"

#   zone_id = data.aws_route53_zone.this4.zone_id

#   records = [
#     {
#       name = local.subdomain4
#       # name = ""
#       type = "CNAME"
#       alias = {
#         name    = module.cloudfront4.cloudfront_distribution_domain_name
#         zone_id = module.cloudfront4.cloudfront_distribution_hosted_zone_id
#       }
#     }
#   ]
# }

data "aws_iam_policy_document" "s3_policy4" {
  # Origin Access Identities
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.s3_one4.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      # identifiers = module.cloudfront4.cloudfront_origin_access_identity_iam_arns
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy4" {
  bucket = module.s3_one4.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_policy4.json
}