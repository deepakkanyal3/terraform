variable "AWS_REGION" {
  type        = string
  # default     = "ap-south-1"
  description = "Provide region in which to deploy TF code"
}


variable "credentials_profile_name" {
  type        = string
  description = "Name of the AWS credentials profile name to use."
}

variable "account" {
  type = string
  # default = "gromo-app-and-backend"
}

variable "environment" {
  type = string
  # default = "stg"
}

variable "vpc_cidr" {
  type = string
  # default = "10.0.16.0/20"
}

variable "appback_vpc_cidr" {
  type = string
  default = "172.31.0.0/16"
}

variable "appback_new_vpc_cidr" {
  type = string
  default = "10.100.0.0/16"
}
variable "new_insurance_stg_vpc_cidr" {
  type = string
  default = "10.140.0.0/16"
}

variable "insure_vpc_cidr" {
  type = string
  default = "10.120.0.0/16"
}

variable "azs" {
  type = list(string)
  # default = [ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]
}

data "aws_caller_identity" "current" {}

locals {
  common_tags = {
    Project = "${var.account}_project"
  }
}

variable "central_account_cidr" {}

variable "hosted_zone" {}
variable "route_53_credential_profile" {}