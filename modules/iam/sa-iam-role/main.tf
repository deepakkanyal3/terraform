data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}
data "aws_caller_identity" "current" {}

locals {
  oidc_url          = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
  oidc_arn_data     = element(split("/", data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer), length(split("/", data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer)) - 1)
  oidc_provider_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.${var.AWS_REGION}.amazonaws.com/id/${local.oidc_arn_data}"
}

resource "aws_iam_role" "eks_role" {
  name               = "${var.account}-${var.environment}-${var.appname}-eks-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${local.oidc_provider_arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${replace(local.oidc_url, "https://", "")}:sub": "system:serviceaccount:${var.namespace}:${var.serviceaccount}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "eks_policy" {
  name        = "${var.account}-${var.environment}-${var.appname}-eks-policy"
  description = "${var.account}-${var.environment}-${var.appname} account policy"
  depends_on  = [
    aws_iam_role.eks_role
  ]
  policy = jsonencode(
    var.policy)
}

resource "aws_iam_role_policy_attachment" "cluster_access" {
  role       = aws_iam_role.eks_role.name
  policy_arn = aws_iam_policy.eks_policy.arn
  depends_on = [
    aws_iam_role.eks_role
  ]
}