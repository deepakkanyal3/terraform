# EKS Cluster Outputs
output "cluster_id" {
  description = "The name/id of the EKS cluster."
  value       = aws_eks_cluster.eks.id
}
output "cluster-name" {
  value = aws_eks_cluster.eks.name
}
output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = aws_eks_cluster.eks.arn
}
output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}
output "cluster-certificate-authority-data" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}
output "cluster-endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = aws_eks_cluster.eks.endpoint
}
output "cluster-version" {
  description = "The Kubernetes server version for the EKS cluster."
  value       = aws_eks_cluster.eks.version
}
output "cluster_primary_security_group_id" {
  description = "The cluster primary security group ID created by the EKS cluster on 1.14 or later. Referred to as 'Cluster security group' in the EKS console."
  value       = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
}
output "cluster-sg" {
  value = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
}
output "node-sg" {
  value = aws_security_group.eks_nodes.id
}

# Output: AWS IAM Open ID Connect Provider ARN
output "aws-iam-openid-connect-provider-arn" {
  description = "AWS IAM Open ID Connect Provider ARN"
  value       = aws_iam_openid_connect_provider.eks.arn
}
output "aws-iam-openid-connect-provider-url" {
  description = "AWS IAM Open ID Connect Provider ARN"
  value       = aws_iam_openid_connect_provider.eks.url
}

# locals {
#   config-map-aws-auth = <<CONFIGMAPAWSAUTH
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   name: aws-auth
#   namespace: kube-system
# data:
#   mapRoles: |
#     - rolearn: aws_iam_role.node_group_general.arn
#       username: system:node:{{EC2PrivateDNSName}}
#       groups:
#         - system:bootstrappers
#         - system:nodes
# CONFIGMAPAWSAUTH

#   kubeconfig = <<KUBECONFIG
# apiVersion: v1
# clusters:
# - cluster:
#     server: aws_eks_cluster.eks.endpoint
#     certificate-authority-data: aws_eks_cluster.eks.certificate_authority.0.data
#   name: kubernetes
# contexts:
# - context:
#     cluster: kubernetes
#     user: aws
#   name: aws
# current-context: aws
# kind: Config
# preferences: {}
# users:
# - name: aws
#   user:
#     exec:
#       apiVersion: client.authentication.k8s.io/v1alpha1
#       command: aws-iam-authenticator
#       args:
#         - "token"
#         - "-i"
#         - "aws_eks_cluster.eks.name"
# KUBECONFIG
# }

# output "config-map-aws-auth" {
#   value = "local.config-map-aws-auth"
# }

# output "kubeconfig" {
#   value = "local.kubeconfig"
# }
