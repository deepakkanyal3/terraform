#tfsec:ignore:aws-iam-no-policy-wildcards
# For private hosted zone
module "aws_managed_addons" {
  source = "../../../../../../modules/eks-addons/aws-managed-addons"
  tags   = local.common_tags
  environment    = var.environment
  addons = [
    {
      name    = "aws-ebs-csi-driver"
      version = "v1.28.0-eksbuild.1"
    }
  ]
  eks_cluster_id = data.aws_eks_cluster.current_eks.id
  account = var.account
}
