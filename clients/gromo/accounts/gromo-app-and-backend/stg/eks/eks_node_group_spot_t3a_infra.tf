# # # ******************************************|   EKS  |**********************************************************
# # # EKS-NodeGroup Module
# # # Type: ON_DEMAND
# # # ***********************************************************************************************************************************************
#tfsec:ignore:aws-ec2-enforce-launch-config-http-token-imds
module "eks-ng-infra-spot" {
  source               = "../../../../../../modules/eks-ng"
  name                 = var.name
  vpc_id               = data.aws_vpc.current_vpc.id
  account              = var.account
  environment          = var.environment
  subnet_ids           = [data.aws_subnet.private_subnet_a.id]
  tags                 = local.common_tags
  # NG configurations
  node_group_name = "infra"
  node_desired_size    = 2
  node_max_size        = 10
  node_min_size        = 2
  node_max_unavailable = 1
  node_ami_type        = "AL2_x86_64"
  node_disk_size       = 100
  node_instance_types  = ["t3a.2xlarge"]
  node_capacity        = "SPOT"
  lt_version           = "1"

  eks_cluster = module.eks-cluster
  eks_iam     = module.eks-iam
  # EKS o/p's:

  #depends_on = [kubernetes_config_map_v1.aws_auth]

  node_group_labels = {
    "node_type" = "infra"
  }
}