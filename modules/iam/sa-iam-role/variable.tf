#**************************************************************************************
# ENV & Tags
#**************************************************************************************
variable "environment" {
  type        = string
  description = "Enter the Environment in which to be deplyed"
}
variable "account" {
  type        = string
}
variable "tags" {}
variable "cluster_name" {}
variable "appname" {}
variable "namespace" {}
variable "serviceaccount" {}
variable "policy" {}
variable "AWS_REGION" {}