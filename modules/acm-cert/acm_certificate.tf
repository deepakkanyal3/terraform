# Resource: ACM Certificate
resource "aws_acm_certificate" "acm_cert" {
  domain_name       = "*.${var.hosted_zone}"
  validation_method = "DNS"
  subject_alternative_names = [var.hosted_zone]

  tags = merge(
    var.tags,
    {
      Account         = var.account
      Environment     = var.environment
      CreatedBy       = data.aws_caller_identity.current.user_id
      CreatedByArn    = data.aws_caller_identity.current.arn
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
    },
    {
      Name = "${var.account}_${var.environment}_acm_certificate"
    }
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"],
    ]
  }
  provider   = aws.vpc_provider
}



data "aws_route53_zone" "hosted_zone" {
  name         = var.hosted_zone
  private_zone = false
  provider   = aws.route53_provider
}

resource "aws_route53_record" "hosted_zone" {
  for_each = {
    for dvo in aws_acm_certificate.acm_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.hosted_zone.zone_id
  provider   = aws.route53_provider
}

resource "aws_acm_certificate_validation" "hosted_zone" {
  certificate_arn         = aws_acm_certificate.acm_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.hosted_zone : record.fqdn]
  provider   = aws.vpc_provider
}

