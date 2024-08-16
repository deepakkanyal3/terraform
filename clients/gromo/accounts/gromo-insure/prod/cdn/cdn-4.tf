locals {
  domain_name = "gromoinsure.co.in" # trimsuffix(data.aws_route53_zone.this.name, ".")
  subdomain   = "statictw"
}

locals {
  domain_name10 = "gromoinsure.in" # trimsuffix(data.aws_route53_zone.this.name, ".")
  subdomain10   = "statictw"
}
#tfsec:ignore:aws-cloudfront-enable-logging
#tfsec:ignore:aws-cloudfront-use-secure-tls-policy
module "cloudfront" {
  source = "../../../../../../modules/cloudfront"

  aliases = ["${local.subdomain10}.${local.domain_name10}"]
  comment             = "tw-insurance-prod"
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

  # create_origin_access_control = true
  # origin_access_control = {
  #   s3_oac = {
  #     description      = "CloudFront access to S3"
  #     origin_type      = "s3"
  #     signing_behavior = "always"
  #     signing_protocol = "sigv4"
  #   }
  # }

  # logging_config = {
  #   bucket = module.log_bucket.s3_bucket_bucket_domain_name
  #   prefix = "cloudfront"
  # }

  origin = {
    # appsync = {
    #   domain_name = "${local.subdomain}.${local.domain_name}"
    #   custom_origin_config = {
    #     http_port              = 80
    #     https_port             = 443
    #     origin_protocol_policy = "match-viewer"
    #     origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    #   }

    #   custom_header = [
    #     {
    #       name  = "X-Forwarded-Scheme"
    #       value = "https"
    #     },
    #     {
    #       name  = "X-Frame-Options"
    #       value = "SAMEORIGIN"
    #     }
    #   ]

    #   origin_shield = {
    #     enabled              = false
    #     origin_shield_region = "ap-south-1"
    #   }
    # }

    # s3_one = { # with origin access identity (legacy)
    #   domain_name = module.s3-bucket.s3_bucket_bucket_regional_domain_name
    #   s3_origin_config = {
    #     origin_access_identity = "s3_bucket_one" # key in `origin_access_identities`
    #     # cloudfront_access_identity_path = "origin-access-identity/cloudfront/E5IGQAA1QO48Z" # external OAI resource
    #   }
    # }
    s3_one = {
      # domain_name = "${local.subdomain4}.${local.domain_name4}"
      domain_name = module.s3-bucket.s3_bucket_bucket_regional_domain_name
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

    # s3_oac = { # with origin access control settings (recommended)
    #   domain_name           = module.s3_one.s3_bucket_bucket_regional_domain_name
    #   origin_access_control = "s3_oac" # key in `origin_access_control`
    #   #      origin_access_control_id = "E345SXM82MIOSU" # external OAС resource
    # }
  # }

  # origin_group = {
  #   group_one = {
  #     failover_status_codes      = [403, 404, 500, 502]
  #     primary_member_origin_id   = "appsync"
  #     secondary_member_origin_id = "s3_one"
  #   }
  # }

  default_cache_behavior = {
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    target_origin_id       = "s3_one"
    viewer_protocol_policy = "redirect-to-https"
    use_forwarded_values = false
    allowed_methods        = ["GET", "HEAD"]
    # allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    #cached_methods         = ["GET", "HEAD"]
    compress               = true
    query_string           = true

  }

  # ordered_cache_behavior = [
  #   {
  #     path_pattern           = "*"
  #     target_origin_id       = "s3_one"
  #     viewer_protocol_policy = "redirect-to-https"

  #     allowed_methods = ["GET", "HEAD", "OPTIONS"]
  #     cached_methods  = ["GET", "HEAD"]
  #     compress        = true
  #     query_string    = true

      # function_association = {
      #   # Valid keys: viewer-request, viewer-response
      #   viewer-request = {
      #     function_arn = aws_cloudfront_function.example.arn
      #   }

      #   viewer-response = {
      #     function_arn = aws_cloudfront_function.example.arn
      #   }
      # }
  #   }
  # ]

  viewer_certificate = {
    # acm_certificate_arn = module.acm-cert.acm_certificate_arn
    acm_certificate_arn = data.aws_acm_certificate.amazon_issued1.arn
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

  # geo_restriction = {
  #   restriction_type = "whitelist"
  #   locations        = ["NO", "UA", "US", "GB"]
  # }

}

######
# ACM
######

data "aws_route53_zone" "this" {
  name = local.domain_name
}

data "aws_acm_certificate" "amazon_issued1" {
  domain      = "*.gromoinsure.in"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
  provider = aws.default-us-east-1
}

# module "acm-cert" {
#   source      = "../../../../../../modules/acm-cert"
#   tags        = local.common_tags
#   environment = var.environment
#   account     = var.account
#   hosted_zone = data.aws_route53_zone.this.name
#   providers = {
#     aws.vpc_provider     = aws.default-us-east-1
#     aws.route53_provider = aws
#   }
# }

#############
# S3 buckets
#############
#tfsec:ignore:aws-s3-encryption-customer-key
module "s3-bucket" {
  source      = "../../../../../../modules/s3"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  consumer    = "User"
  producer    = "CDN"
  bucket      = "tw-insurance"
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
  website = {
    index_document = "index.html"
  }
}

# module "log_bucket" {
#   source  = "terraform-aws-modules/s3-bucket/aws"
#   version = "~> 3.0"

#   bucket = "logs-${random_pet.this.id}"
#   acl    = null
#   grant = [{
#     type       = "CanonicalUser"
#     permission = "FULL_CONTROL"
#     id         = data.aws_canonical_user_id.current.id
#     }, {
#     type       = "CanonicalUser"
#     permission = "FULL_CONTROL"
#     id         = data.aws_cloudfront_log_delivery_canonical_user_id.cloudfront.id
#     # Ref. https://github.com/terraform-providers/terraform-provider-aws/issues/12512
#     # Ref. https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html
#   }]
#   force_destroy = true
# }

#############################################
# Using packaged function from Lambda module
#############################################

# locals {
#   package_url = "https://raw.githubusercontent.com/terraform-aws-modules/terraform-aws-lambda/master/examples/fixtures/python3.8-zip/existing_package.zip"
#   downloaded  = "downloaded_package_${md5(local.package_url)}.zip"
# }

# resource "null_resource" "download_package" {
#   triggers = {
#     downloaded = local.downloaded
#   }

#   provisioner "local-exec" {
#     command = "curl -L -o ${local.downloaded} ${local.package_url}"
#   }
# }

# module "lambda_function" {
#   source  = "terraform-aws-modules/lambda/aws"
#   version = "~> 4.0"

#   function_name = "${random_pet.this.id}-lambda"
#   description   = "My awesome lambda function"
#   handler       = "index.lambda_handler"
#   runtime       = "python3.8"

#   publish        = true
#   lambda_at_edge = true

#   create_package         = false
#   local_existing_package = local.downloaded

  # @todo: Missing CloudFront as allowed_triggers?

  #    allowed_triggers = {
  #      AllowExecutionFromAPIGateway = {
  #        service = "apigateway"
  #        arn     = module.api_gateway.apigatewayv2_api_execution_arn
  #      }
  #    }
# }

########
# Route53
##########

# module "records" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"

#   zone_id = data.aws_route53_zone.this.zone_id

#   records = [
#     {
#       name = local.subdomain
#       type = "CNAME"
#       alias = {
#         name    = module.cloudfront.cloudfront_distribution_domain_name
#         zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
#       }
#     },
#   ]
# }

data "aws_iam_policy_document" "s3_policy" {
  # Origin Access Identities
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.s3-bucket.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = module.cloudfront.cloudfront_origin_access_identity_iam_arns
      # identifiers = ["*"]
    }
  }

  # # Origin Access Controls
  # statement {
  #   actions   = ["s3:GetObject"]
  #   resources = ["${module.s3-bucket.s3_bucket_arn}/*"]

  #   principals {
  #     type        = "Service"
  #     identifiers = ["cloudfront.amazonaws.com"]
  #   }

  #   condition {
  #     test     = "StringEquals"
  #     variable = "aws:SourceArn"
  #     values   = [module.cloudfront.cloudfront_distribution_arn]
  #   }
  # }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = module.s3-bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_policy.json
}

########
# Extra
########

# resource "random_pet" "this" {
#   length = 2
# }

# resource "aws_cloudfront_function" "example" {
#   name    = "example-${random_pet.this.id}"
#   runtime = "cloudfront-js-1.0"
#   code    = file("${path.module}/example-function.js")
# }