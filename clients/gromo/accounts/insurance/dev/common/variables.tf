variable "AWS_REGION" {
  type        = string
  # default     = "ap-south-1"
  description = "Provide region in which to deploy TF code"
}

variable "credentials_profile_name" {
  type        = string
  # default     = "insurance"
  description = "Name of the AWS credentials profile name to use."
}


variable "account" {
  type = string
  # default = "insurance"
}

variable "environment" {
  type = string
  # default = "dev"
}

variable "vpc_cidr" {
  type = string
  # default = "10.0.16.0/20"
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

 variable "hosted_zone" {}
 variable "route_53_credential_profile" {}