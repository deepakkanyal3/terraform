#**************************************************************************************
# ENV & Tags
#**************************************************************************************
variable "tags" {}

variable "eks_cluster_id" {}

variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))
}
data "aws_caller_identity" "current" {}
variable "account" {}
variable "environment" {}