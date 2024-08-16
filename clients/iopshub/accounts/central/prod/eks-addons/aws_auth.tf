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
      rolearn  = "arn:aws:iam::346173481489:user/akshay"
      username = "eks-admin-akshay" # Just a place holder name
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::346173481489:user/deepak.kanyal@iopshub.com"
      username = "eks-admin-deepak" # Just a place holder name
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::346173481489:user/hitesh.yadav@iopshub.com"
      username = "eks-admin-hitesh" # Just a place holder name
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::346173481489:user/iopshub-dhruv"
      username = "eks-admin-dhruv" # Just a place holder name
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::346173481489:user/iopshub-pushpit01"
      username = "eks-admin-pushpit" # Just a place holder name
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::346173481489:user/vipul.pancholi@iopshub.com"
      username = "eks-admin-vipul" # Just a place holder name
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::346173481489:user/yuvraj.gupta@iopshub.com"
      username = "eks-admin-yuvraj" # Just a place holder name
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::346173481489:user/adarsh.gupta@iopshub.com"
      username = "eks-admin-adarsh" # Just a place holder name
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

