data "aws_iam_role" "ng-iam" {
  name = "${var.account}-${var.name}-${var.environment}-ng-general"
}
data "aws_iam_role" "admin-iam" {
  name = "${var.account}-${var.name}-${var.environment}-admin-role"
}



# Locals Block
locals {
  config_map_roles = [
    # Node-group role ARN with which NG was created
    {
      rolearn  = data.aws_iam_role.ng-iam.arn # Node-group role ARN with which NG was created
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:bootstrappers", "system:nodes"]
    },
    # EKS ADMIN ROLE for Cluster
    {
      rolearn  = data.aws_iam_role.admin-iam.arn
      username = "eks-admin"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::718331536885:user/gromo-insure-prod"
      username = "eks-admin-gromo-insure-prod" # Just a place holder name
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::718331536885:user/iops.hub@gromo.in"
      username = "eks-admin-iops.hub" # Just a place holder name
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::360751932080:user/iops.hub.write"
      username = "eks-admin-iops.hub.write" # Just a place holder name
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::718331536885:user/iops.hub.readonly"
      username = "eks-admin-iops.hub.readonly" # Just a place holder name
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::718331536885:role/OrganizationAccountAccessRole"
      username = "eks-admin-org-account-role" # Just a place holder name
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::718331536885:role/AdminRole"
      username = "eks-admin-role" # Just a place holder name
      groups   = ["system:masters"]
    }
    
    
  ]

}

resource "kubernetes_config_map_v1_data" "aws_auth" {
  
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