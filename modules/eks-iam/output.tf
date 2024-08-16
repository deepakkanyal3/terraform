output "ng-role-arn" {
  value = aws_iam_role.node_group_general.arn
}
output "amazon-eks-worker-node-policy-general" {
  value = aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general
}
output "amazon-eks-cni-policy-general" {
  value = aws_iam_role_policy_attachment.amazon_eks_cni_policy_general
}
output "amazon-ec2-container-registry-read-only" {
  value = aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only
}
output "cluster-iam-role-name" {
  description = "IAM role name of the EKS cluster."
  value       = aws_iam_role.eks_cluster_role.name
}
output "cluster-iam-role-arn" {
  description = "IAM role ARN of the EKS cluster."
  value       = aws_iam_role.eks_cluster_role.arn
}
output "amazon-eks-cluster-policy" {
  value = aws_iam_role_policy_attachment.amazon_eks_cluster_policy
}
output "eks-admin-role" {
  value = aws_iam_role.eks_admin_role.arn
}
output "eks-readonly-role" {
  value = aws_iam_role.eks_readonly_role.arn
}
//output "eks-readonly-groupname" {
//  value = kubernetes_cluster_role_binding_v1.eksreadonly_clusterrolebinding.subject[0].name
//}
# output "aws-auth-configmap" {
#   value = kubernetes_config_map_v1.aws_auth
# }