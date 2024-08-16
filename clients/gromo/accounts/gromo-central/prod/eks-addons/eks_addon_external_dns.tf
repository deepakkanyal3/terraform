#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_route53_zone" "route53" {
  name         = "${var.hosted_zone}."
  private_zone = false
  provider = aws.route_53_credential_profile
}
module "external_dns" {
  source                   = "../../../../../../modules/eks-addons/external-dns"
  name                     = "external_dns"
  eks_cluster_id           = data.aws_eks_cluster.current_eks.id
  aws_region               = var.AWS_REGION
  eks_cluster              = data.aws_eks_cluster.current_eks.name
  service_account_name     = "external-dns-ingress"
  hosted_zone_list         = [data.aws_route53_zone.route53.arn]
  url                      = data.aws_eks_cluster.current_eks.identity.0.oidc.0.issuer
  values_file              = templatefile("externaldns_values.yaml", {})
  cross_account = true
  providers = {
    aws.vpc_provider     = aws
    aws.route53_provider = aws.route_53_credential_profile
  }
}

