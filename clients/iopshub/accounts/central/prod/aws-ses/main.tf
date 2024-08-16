module "aws-ses" {
source      = "../../../../../../modules/aws-ses"
hosted_zone = var.hosted_zone
providers = {
    aws.ses = aws
    aws.route53  = aws.route_53_credential_profile
}

}