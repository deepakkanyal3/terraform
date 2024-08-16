# Locals Block
locals {
  config_map_roles = [
    # Node-group role ARN with which NG was created check
    {
      rolearn  = module.eks-iam.ng-role-arn # Node-group role ARN with which NG was created
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:bootstrappers", "system:nodes"]
    },
    # EKS ADMIN ROLE for Cluster
    {
      rolearn  = module.eks-iam.eks-admin-role
      username = "eks-admin"
      groups   = ["system:masters"]
    },
    # SSO ADMIN access for EKS Cluster in devtest
    {
      rolearn  = "arn:aws:iam::527374893274:role/OrganizationAccountAccessRole"
      username = "eks-sso-admin" # Just a place holder name
      groups   = ["system:masters"]
    }
  ]
  configmap_users = [
    {
      userarn  = "arn:aws:iam::527374893274:user/iops.hub@gromo.in"
      username = "admin-user"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::527374893274:user/atlantis"
      username = "admin-user-1"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::527374893274:role/AdminRole"
      username = "EKS-AdminRole"
      groups   = ["system:masters"]
    }
  ]
}


resource "kubernetes_config_map_v1_data" "aws_auth" {
  depends_on = [module.eks-cluster.cluster_id]
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  data = {
    mapRoles = yamlencode(local.config_map_roles)
    mapUsers = yamlencode(local.configmap_users)
  }
  force = true
}

