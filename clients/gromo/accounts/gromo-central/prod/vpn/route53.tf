
resource "aws_route53_record" "private" {
  count = var.private_hosted_zone_enabled == true ? 1 : 0
  zone_id = data.aws_route53_zone.private_hosted_zone[0].id
  name    = "${var.appname}.${var.hosted_zone}"
  type    = "A"
  ttl     = 300
  records = [module.server-01.private_ip]
  provider = aws.route_53_credential_profile
}

resource "aws_route53_record" "public" {
  zone_id = data.aws_route53_zone.public_hosted_zone.id
  name    = "${var.appname}.${var.hosted_zone}"
  type    = "A"
  ttl     = 300
  records = [aws_eip.ip-01.public_ip]
  provider = aws.route_53_credential_profile
}