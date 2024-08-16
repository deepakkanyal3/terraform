#tfsec:ignore:aws-ec2-no-public-egress-sgr
#tfsec:ignore:aws-eks-encrypt-secrets
#tfsec:ignore:aws-cloudwatch-log-group-customer-key
#tfsec:ignore:aws-ec2-add-description-to-security-group-rule
module "eks-cluster" {
  source      = "../../../../../../modules/eks"
  vpc_id      = data.aws_vpc.current_vpc.id
  environment = var.environment
  subnet_ids  = [
    data.aws_subnet.private_subnet_a.id, data.aws_subnet.private_subnet_b.id, data.aws_subnet.private_subnet_c.id
  ]
  tags                      = local.common_tags
  name                      = var.name
  eks_version               = var.cluster_version
  ekscluster_role_arn       = module.eks-iam.cluster-iam-role-arn
  amazon_eks_cluster_policy = module.eks-iam.amazon-eks-cluster-policy
  cluster_access_cidrs      = distinct([var.vpc_cidr, var.central_account_cidr])
  account                   = var.account
  cluster_log_types = []
  log_retention = 30

}