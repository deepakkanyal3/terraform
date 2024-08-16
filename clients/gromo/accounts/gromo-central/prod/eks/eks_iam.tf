#tfsec:ignore:aws-iam-no-policy-wildcards
#tfsec:ignore:aws-iam-enforce-group-mfa

module "eks-iam" {
  source           = "../../../../../../modules/eks-iam"
  name             = var.name
  tags             = local.common_tags
  environment      = var.environment
  account          = var.account
  eks_cluster      = module.eks-cluster.cluster_id
  config_map_roles = local.config_map_roles
}