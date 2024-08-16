#tfsec:ignore:aws-iam-no-policy-wildcards
# ******************************************|   Cluster-AutoScaler  |**********************************************************
# EKS Cluster-AutoScaler
# Note: Run this module after creation of EKS Cluster
# *****************************************************************************************************************************
#tfsec:ignore:aws-iam-no-policy-wildcards
module "cluster-autoscaler" {
  source                              = "../../../../../../modules/eks-addons/cluster-autoscaler"
  tags                                = local.common_tags
  environment                         = var.environment
  account                             = var.account   
  eks_cluster_id                      = data.aws_eks_cluster.current_eks.id
  cluster_name                        = data.aws_eks_cluster.current_eks.name
  chart_version                       = "9.37.0"
  image_tag                           = "v1.30.0"
  aws_region                          = var.AWS_REGION
  name = var.name
}
