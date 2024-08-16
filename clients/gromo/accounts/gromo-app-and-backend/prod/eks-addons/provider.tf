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

provider "aws" {
  region  = var.AWS_REGION
  profile = var.route_53_credential_profile
  alias   = "route_53_credential_profile"
}

data "aws_eks_cluster" "eks" {
  name       = "${var.account}-${var.name}-${var.environment}"
}
data "aws_eks_cluster_auth" "eks" {
  name = "${var.account}-${var.name}-${var.environment}"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  token                  = data.aws_eks_cluster_auth.eks.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority.0.data)
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

# # Terraform HTTP Provider Block
provider "http" {
  # Configuration options
}