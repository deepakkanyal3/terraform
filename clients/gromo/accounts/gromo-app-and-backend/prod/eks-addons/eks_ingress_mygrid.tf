module "external-ingress-mygrid" {
  source                   = "../../../../../../modules/eks-addons/nginx-ingress"
  tags                     = local.common_tags
  eks_cluster              = data.aws_eks_cluster.current_eks.id
  name                     = "external-ingress-mygrid"
  helm_chart               = "ingress-nginx"
  namespace                = "external-ingress-mygrid"
  helm_repository          = "https://kubernetes.github.io/ingress-nginx"
  chart_version            = "4.4.2"
  atomic                   = false
  create_namespace         = true
  wait                     = true
  timeout                  = 300
  ingress_class_name       = "external-ingress-mygrid"
  ingress_class_is_default = true
  is_service_account       = true
  service_account_name     = "external-ingress-mygrid"
  metrics_enabled          = true
  values_file              = templatefile("ingress_values.yaml", {
    vpc_cidr = var.vpc_cidr
    lb_name = "${var.account}-${var.name}-${var.environment}-pub-lb"
    acm_arn = data.aws_acm_certificate.acm_cert_mygrid.arn
    internal = false
    ingress_class = "external-ingress-mygrid"
  })
}

