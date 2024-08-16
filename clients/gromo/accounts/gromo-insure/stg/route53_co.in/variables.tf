variable "AWS_REGION" {
  type        = string
  description = "Provide region in which to deploy TF code"
}

variable "credentials_profile_name" {
  type        = string
  description = "Name of the AWS credentials profile name to use."
}


variable "account" {
  type    = string
}

variable "environment" {
  type    = string
}

variable "vpc_cidr" {
  type        = string
}

variable "azs" {
  type  = list(string)
}

data "aws_caller_identity" "current" {}

locals {
  common_tags = {
    Project         = "${var.account}_project"
  }
}

data "aws_vpc" "current_vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.account}-vpc-${var.environment}"]
  }
}

variable "zone_id" {
  description = "ID of DNS zone"
  type        = string
  default     = "Z056400832CY7BP5BNUR7"
}

variable "zone_name" {
  description = "Name of DNS zone"
  type        = string
  default     = "gromoinsure.co.in"
}

variable "pub_alb" {
  description = "Public dns"
  type        = string
  default     = "gromoinsure.co.in"
}

variable "internal_record_id" {
  type    = string
  default = "ZP97RAFLXTNZK"
}

variable "central_account_cidr" {}
#variable "route_53_credential_profile" {}
#variable "hosted_zone" {}
variable "pem_key" {}
#variable "private_hosted_zone_enabled" {}

# data "aws_route53_zone" "private_hosted_zone" {
#   count = var.private_hosted_zone_enabled == true ? 1 : 0
#   name         = var.hosted_zone
#   private_zone = true
#   provider   = aws.route_53_credential_profile
# }

# data "aws_route53_zone" "public_hosted_zone" {
#   name         = var.hosted_zone
#   private_zone = false
#   provider   = aws.route_53_credential_profile
# }