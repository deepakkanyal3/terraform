#**************************************************************************************
# ENV & Tags
#**************************************************************************************

variable "account" {}
variable "environment" {}
data "aws_caller_identity" "current" {}

variable "tags" {}
variable "vpc_id" {}

#**************************************************************************************
# EKS Cluster Related variables
#**************************************************************************************
variable "name" {
  description = "EKS Cluster Name"
}
variable "eks_version" {
  description = "EKS Version to be used"
}
# variable "cluster_service_ipv4_cidr" {}
variable "ekscluster_role_arn" {}
variable "amazon_eks_cluster_policy" {}
#**************************************************************************************
# EKS Cluster Subnets
#**************************************************************************************
# These subnets will come from VPC modules
variable "subnet_ids" {}
variable "cluster_access_cidrs" {}

variable cluster_log_types {
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable log_retention {
  default     = 30
}

