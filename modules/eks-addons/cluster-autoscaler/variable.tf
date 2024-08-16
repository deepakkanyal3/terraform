#**************************************************************************************
# ENV & Tags
#**************************************************************************************

variable "environment" {
  type        = string
  description = "Enter the Environment in which to be deplyed"
}
variable "tags" {}
variable "aws_region" {}
#**************************************************************************************
# Cluster-AutoScaler specific variables
#**************************************************************************************
variable "chart_version" {}
variable "image_tag" {}
#**************************************************************************************
# EKS OIDC and Networking variables 
#**************************************************************************************

variable "eks_cluster_id" {}
variable "cluster_name"{}
variable "account" {}
variable "name" {}
variable "values_file" {
  default = ""
}