# ******************************************|  nginx-ingress  |**********************************************************
# nginx-ingress Controller
# Note: Run this module after creation of EKS Cluster
# ***********************************************************************************************************************
# Private Ingress  - For Private hosted zone
# module "internal-ingress" {
#   source                   = "../../../../../../modules/eks-addons/nginx-ingress"
#   tags                     = local.common_tags
#   eks_cluster              = data.aws_eks_cluster.current_eks.id
#   name                     = "internal-nginx-ingress"
#   helm_chart               = "ingress-nginx"
#   namespace                = "private-ingress"
#   helm_repository          = "https://kubernetes.github.io/ingress-nginx"
#   chart_version            = "4.4.2"
#   atomic                   = true
#   create_namespace         = true
#   wait                     = true
#   timeout                  = 300
#   ingress_class_name       = "internal-ingress"
#   ingress_class_is_default = false
#   is_service_account       = true
#   service_account_name     = "private-nginx"
#   metrics_enabled          = true
#   values_file              = templatefile("ingress_values.yaml", {
#     vpc_cidr = var.vpc_cidr
#     lb_name = "${var.account}-${var.name}-${var.environment}-pvt-lb"
#     acm_arn = data.aws_acm_certificate.acm_cert.arn
#     internal = true
#     ingress_class = "internal-ingress"
#   })
#   depends_on = [kubernetes_config_map_v1_data.aws_auth]
# }


## Public Ingress - For Public hosted Zone
# module "external-ingress" {
#   source                   = "../../../../../../modules/eks-addons/nginx-ingress"
#   tags                     = local.common_tags
#   eks_cluster              = data.aws_eks_cluster.current_eks.id
#   name                     = "external-nginx-ingress"
#   helm_chart               = "ingress-nginx"
#   namespace                = "public-ingress"
#   helm_repository          = "https://kubernetes.github.io/ingress-nginx"
#   chart_version            = "4.4.2"
#   atomic                   = false
#   create_namespace         = true
#   wait                     = true
#   timeout                  = 300
#   ingress_class_name       = "external-ingress"
#   ingress_class_is_default = true
#   is_service_account       = true
#   service_account_name     = "external-nginx"
#   metrics_enabled          = true
#   values_file              = templatefile("ingress_values.yaml", {
#     vpc_cidr = var.vpc_cidr
#     lb_name = "${var.account}-${var.name}-${var.environment}-pub-lb"
#     acm_arn = data.aws_acm_certificate.acm_cert.arn
#     internal = false
#     ingress_class = "external-ingress"
#   })
#   depends_on = [kubernetes_config_map_v1_data.aws_auth]
# }
