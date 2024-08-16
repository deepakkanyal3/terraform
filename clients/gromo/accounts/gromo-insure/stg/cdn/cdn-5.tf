#######################################################

locals {
  domain_name5 = "gromoinsure.in" # trimsuffix(data.aws_route53_zone.this.name, ".")
  subdomain5   = "sales-stg"
}

# locals {
#   domain_name11 = "gromoinsure.in" # trimsuffix(data.aws_route53_zone.this.name, ".")
#   subdomain11   = "sales"
# }
#tfsec:ignore:aws-cloudfront-use-secure-tls-policy
#tfsec:ignore:aws-cloudfront-enable-logging
module "cloudfront5" {
  source = "../../../../../../modules/cloudfront"

  aliases = ["${local.subdomain5}.${local.domain_name5}"]
  comment             = "Sales GroMo Insure Stg"
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
  # origin_access_identities = {
  #   s3_bucket_one = "My awesome CloudFront can access"
  # }

  # origin = {
  #   s3_one = { # with origin access identity (legacy)
  #     domain_name = module.s3_one5.s3_bucket_bucket_regional_domain_name
  #     s3_origin_config = {
  #       origin_access_identity = "s3_bucket_one" # key in `origin_access_identities`
  #       # cloudfront_access_identity_path = "origin-access-identity/cloudfront/E5IGQAA1QO48Z" # external OAI resource
  #     }
  #   }
  # }
    origin = {
    s3_one = {
      # domain_name = "${local.subdomain4}.${local.domain_name4}"
      domain_name = module.s3_one5.s3_bucket_website_endpoint
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
    viewer_protocol_policy = "allow-all"
    use_forwarded_values = false
    allowed_methods        = ["GET", "HEAD"]
    # allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    #cached_methods         = ["GET", "HEAD"]
    compress               = true
    query_string           = true

  }

  viewer_certificate = {
    # acm_certificate_arn = module.acm-cert2.acm_certificate_arn
    acm_certificate_arn = data.aws_acm_certificate.amazon_issued5.arn
    ssl_support_method  = "sni-only"
  }

  custom_error_response = [{
    error_caching_min_ttl = 10
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
    }]

}

####
# ACM
######

# data "aws_route53_zone" "this5" {
#   name = local.domain_name5
# }

# Find a certificate issued by (not imported into) ACM
data "aws_acm_certificate" "amazon_issued5" {
  domain      = "*.gromoinsure.in"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
  provider = aws.default-us-east-1
}

# Find a RSA 4096 bit certificate
# data "aws_acm_certificate" "rsa_2048-2" {
#   domain    = "*.gromoinsure.co.in"
#   key_types = ["RSA_2048"]
# }

# module "acm-cert2" {
#   source      = "../../../../../../modules/acm-cert"
#   tags        = local.common_tags
#   environment = var.environment
#   account     = var.account
#   hosted_zone = data.aws_route53_zone.this2.name
#   providers = {
#     aws.vpc_provider     = aws.default-us-east-1
#     aws.route53_provider = aws
#   }
# }

#############
# S3 buckets
#############
#tfsec:ignore:aws-s3-block-public-acls
#tfsec:ignore:aws-s3-block-public-policy
#tfsec:ignore:aws-s3-ignore-public-acls
#tfsec:ignore:aws-s3-no-public-buckets
#tfsec:ignore:aws-s3-encryption-customer-key
#tfsec:ignore:aws-s3-enable-bucket-logging
#tfsec:ignore:aws-s3-enable-bucket-encryption
#tfsec:ignore:aws-s3-enable-versioning
module "s3_one5" {
  source      = "../../../../../../modules/s3"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  consumer    = "User"
  producer    = "CDN"
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls  = false
  restrict_public_buckets = false
  bucket      = "sales-stg.gromoinsure.in"
  website = {
    index_document = "index.html"
  }
}

##########
# Route53
##########

# module "records3" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"

#   zone_id = data.aws_route53_zone.this3.zone_id

#   records = [
#     {
#       name = local.subdomain3
#       type = "CNAME"
#       alias = {
#         name    = module.cloudfront3.cloudfront_distribution_domain_name
#         zone_id = module.cloudfront3.cloudfront_distribution_hosted_zone_id
#       }
#     },
#   ]
# }

data "aws_iam_policy_document" "s3_policy5" {
  # Origin Access Identities
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.s3_one5.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      # identifiers = module.cloudfront5.cloudfront_origin_access_identity_iam_arns
      identifiers = ["*"]
    }
  }

  # # Origin Access Controls
  # statement {
  #   actions   = ["s3:GetObject"]
  #   resources = ["${module.s3_one5.s3_bucket_arn}/*"]

  #   principals {
  #     type        = "Service"
  #     identifiers = ["cloudfront.amazonaws.com"]
  #   }

  #   condition {
  #     test     = "StringEquals"
  #     variable = "aws:SourceArn"
  #     values   = [module.cloudfront5.cloudfront_distribution_arn]
  #   }
  # }
}

resource "aws_s3_bucket_policy" "bucket_policy5" {
  bucket = module.s3_one5.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_policy5.json
}