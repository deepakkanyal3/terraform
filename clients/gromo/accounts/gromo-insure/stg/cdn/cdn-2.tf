#######################################################

locals {
  domain_name2 = "gromoinsure.in" # trimsuffix(data.aws_route53_zone.this.name, ".")
  subdomain2   = "staticmi-stg"
}

# locals {
#   domain_name8 = "gromoinsure.in" # trimsuffix(data.aws_route53_zone.this.name, ".")
#   subdomain8   = "staticmi"
# }
#tfsec:ignore:aws-cloudfront-enable-logging
#tfsec:ignore:aws-cloudfront-use-secure-tls-policy
module "cloudfront2" {
  source = "../../../../../../modules/cloudfront"

  aliases = ["${local.subdomain2}.${local.domain_name2}"]
  comment             = "motor-insurance-stg"
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
    s3_bucket_one = "My awesome CloudFront can access"
  }

  origin = {
    s3_one = {
      # domain_name = "${local.subdomain4}.${local.domain_name4}"
      domain_name = module.s3_one2.s3_bucket_bucket_regional_domain_name
      s3_origin_config = {
        origin_access_identity = "s3_bucket_one" # key in `origin_access_identities`
        # cloudfront_access_identity_path = "origin-access-identity/cloudfront/E5IGQAA1QO48Z" # external OAI resource
      }
    }
    }
  # }

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

  # ordered_cache_behavior = [
  # {
  #     cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  #     path_pattern           = "*"
  #     target_origin_id       = "s3_one"
  #     viewer_protocol_policy = "allow-all"

  #     allowed_methods = ["GET", "HEAD"]
  #     cached_methods  = ["GET", "HEAD"]
  #     compress        = true
  #     query_string    = true

  #     # function_association = {
  #     #   # Valid keys: viewer-request, viewer-response
  #     #   viewer-request = {
  #     #     function_arn = aws_cloudfront_function.example.arn
  #     #   }

  #     #   viewer-response = {
  #     #     function_arn = aws_cloudfront_function.example.arn
  #     #   }
  #     # }
  #   }
  # ]

  viewer_certificate = {
    # acm_certificate_arn = module.acm-cert2.acm_certificate_arn
    acm_certificate_arn = data.aws_acm_certificate.amazon_issued2.arn
    ssl_support_method  = "sni-only"
  }

  # custom_error_response = [{
  #   error_code         = 404
  #   response_code      = 404
  #   response_page_path = "/errors/404.html"
  #   }, {
  #   error_code         = 403
  #   response_code      = 403
  #   response_page_path = "/errors/403.html"
  # }]

}

######
# ACM
######

# data "aws_route53_zone" "this2" {
#   name = local.domain_name2
# }

# Find a certificate issued by (not imported into) ACM
data "aws_acm_certificate" "amazon_issued2" {
  domain      = "*.gromoinsure.in"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
  provider = aws.default-us-east-1
}

#############
# S3 buckets
#############
#tfsec:ignore:aws-s3-enable-bucket-logging
#tfsec:ignore:aws-s3-enable-bucket-encryption
#tfsec:ignore:aws-s3-enable-versioning
#tfsec:ignore:aws-s3-encryption-customer-key
module "s3_one2" {
  source      = "../../../../../../modules/s3"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  consumer    = "User"
  producer    = "CDN"
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
  bucket      = "motor-insurance"
  # website = {
  #   index_document = "index.html"
  # }
}

##########
# Route53
##########

# module "records2" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"

#   zone_id = data.aws_route53_zone.this2.zone_id

#   records = [
#     {
#       name = local.subdomain2
#       type = "CNAME"
#       alias = {
#         name    = module.cloudfront2.cloudfront_distribution_domain_name
#         zone_id = module.cloudfront2.cloudfront_distribution_hosted_zone_id
#       }
#     },
#   ]
# }

data "aws_iam_policy_document" "s3_policy2" {
  # Origin Access Identities
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.s3_one2.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = module.cloudfront2.cloudfront_origin_access_identity_iam_arns
      # identifiers = ["*"]
    }
  }
    # Origin Access Controls
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.s3_one2.s3_bucket_arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [module.cloudfront2.cloudfront_distribution_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy2" {
  bucket = module.s3_one2.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_policy2.json
}