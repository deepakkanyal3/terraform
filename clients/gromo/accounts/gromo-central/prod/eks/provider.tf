terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.AWS_REGION
  profile = var.credentials_profile_name
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks-cluster.cluster_id
}
data "aws_eks_cluster" "eks" {
  name       = module.eks-cluster.cluster-name
  depends_on = [module.eks-cluster.cluster_arn]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  token                  = data.aws_eks_cluster_auth.eks.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority.0.data)
}