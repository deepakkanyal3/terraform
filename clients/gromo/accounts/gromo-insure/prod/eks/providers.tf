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


# please keep the code below this line commented till your cluster is not ready.
# you also need to disable the aws_auth.tf till the time cluster is not created 
# with atleast one node group. 

# once cluster is ready please uncomment the code below and aws_auth.tf as well.
# data "aws_eks_cluster" "eks" {
#   name       = "${var.account}-${var.name}-${var.environment}"
# }
# data "aws_eks_cluster_auth" "eks" {
#   name = "${var.account}-${var.name}-${var.environment}"
# }

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.eks.endpoint
#   token                  = data.aws_eks_cluster_auth.eks.token
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority.0.data)
# }

provider "aws" {
  region  = var.AWS_REGION
  profile = "gromo-insure-prod"
  alias   = "gromo-insure-prod"
}