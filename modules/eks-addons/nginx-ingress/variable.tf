variable "name" {
  type        = string
  description = "Name of helm release"
}
variable "helm_chart" {}
variable "namespace" {
  type        = string
  description = "Name of namespace where nginx controller should be deployed"
}
variable "helm_repository" {}
variable "chart_version" {
  type        = string
  description = "HELM Chart Version for nginx controller"
}
variable "atomic" {
  type        = bool
  description = "If set, installation process purges chart on fail"
}
variable "create_namespace" {
  type        = bool
  description = "Create a namespace"
}
variable "wait" {
  description = "Will wait until all resources are in a ready state"
  type        = bool
}
variable "timeout" {
  type        = number
  description = "Time in seconds to wait for any individual kubernetes operation"
}


variable "ingress_class_name" {
  type        = string
  description = "IngressClass resource name"
}
variable "ingress_class_is_default" {
  type        = bool
  description = "IngressClass resource default for cluster"
}
variable "is_service_account" {}
variable "service_account_name" {}
variable "metrics_enabled" {
  type        = bool
  description = "Allow exposing metrics for prometheus-operator"
}
variable "values_file" {}

#**************************************************************************************
# ENV & Tags
#**************************************************************************************

variable "tags" {}
variable "eks_cluster" {}