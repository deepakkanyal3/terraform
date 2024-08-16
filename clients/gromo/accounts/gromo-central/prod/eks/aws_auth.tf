# Locals Block
locals {
  config_map_roles = [
    # Node-group role ARN with which NG was created
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
    #    {
    #      rolearn  = "arn:aws:iam::74xxxxxx:role/sso_admin"
    #      username = "eks-sso-admin" # Just a place holder name
    #      groups   = ["system:masters"]
    #    }
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
    #mapUsers = yamlencode(local.configmap_users)
  }
  force = true
}

