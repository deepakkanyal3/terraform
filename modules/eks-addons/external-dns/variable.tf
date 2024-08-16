# variable "service_account_name" {}

#**************************************************************************************
# ENV & Tags
#**************************************************************************************

# variable "tags" {}
variable "eks_cluster" {}
variable "aws_region" {}
variable "eks_cluster_id" {}
variable "name" {
  type        = string
  description = "Name of helm release"
}

variable "chart_version" {
  default = "1.13.0"
 }
terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.vpc_provider, aws.route53_provider]
    }
  }
}

variable "cross_account" {
  default = true
}

variable "url" {
  type        = string
  default = "https://oidc.eks.ap-south-1.amazonaws.com/id/98EE0A158A1B74BB28EDB54C7EDA0D04"
}

variable "auto_thumbprint_enabled" {
  description = "(Optional) Whether to automatically calculate thumbprint of the server certificate."
  type        = bool
  default     = true
  nullable    = false
}

variable "audiences" {
  type        = set(string)
  default     = ["sts.amazonaws.com"]
  nullable    = false
}

variable "thumbprints" {
  description = "(Optional) A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s)."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "namespace" {
  type        = string
  default     = "private-ingress"
  description = "The K8s namespace in which the external-dns will be installed"
}

variable "service_account_name" {
  type        = string
  default     = "external-dns-ingress"
  description = "The k8s external-dns service account name"
}


variable hosted_zone_list {
  type        = list
  default     = []
  description = "description"
}
variable "values_file" {}


