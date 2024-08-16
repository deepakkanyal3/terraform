# # # ******************************************|   EKS  |**********************************************************
# # # EKS-NodeGroup Module
# # # Type: ON_DEMAND
# # # ***********************************************************************************************************************************************

module "eks-ng-ondemand" {
  source               = "../../../../../../modules/eks-ng"
  name                 = var.name
  vpc_id               = data.aws_vpc.current_vpc.id
  account              = var.account
  environment          = var.environment
  subnet_ids           = [data.aws_subnet.private_subnet_a.id]
  tags                 = local.common_tags
  # NG configurations
  node_group_name = "t3a"
  node_desired_size    = 0
  node_max_size        = 2
  node_min_size        = 0
  node_max_unavailable = 1
  node_ami_type        = "AL2_x86_64"
  node_disk_size       = 200
  node_instance_types  = ["t3a.xlarge"]
  node_capacity        = "ON_DEMAND"
  lt_version           = "1"

  eks_cluster = module.eks-cluster
  eks_iam     = module.eks-iam
  # EKS o/p's:

  #depends_on = [kubernetes_config_map_v1.aws_auth]
  allow_taints = true
  node_taints = [
    {
      key    = "on-demand"
      value  = "true"
      effect = "NO_SCHEDULE"
    }
  ]
}