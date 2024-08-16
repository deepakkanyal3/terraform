resource "aws_ses_domain_identity" "aws_ses" {
  domain = var.hosted_zone
  provider      = aws.ses
}
data "aws_route53_zone" "hosted_zone" {
  name         = var.hosted_zone
  private_zone = false
  provider   = aws.route53
}
resource "aws_route53_record" "amazonses_verification_record" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "_amazonses.${var.hosted_zone}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.aws_ses.verification_token]
  provider = aws.route53
}