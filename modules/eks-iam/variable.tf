#**************************************************************************************
# ENV & Tags
#**************************************************************************************

variable "environment" {
  type        = string
  description = "Enter the Environment in which to be deplyed"
}
variable "tags" {}
variable "name" {}
variable "account" {}
variable "eks_cluster" {}
variable "config_map_roles" {
  default = null
}
data "aws_caller_identity" "current" {}

