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

variable "appname" {
  default = "loki"
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

data "aws_subnet" "public_subnet_a" {
  filter {
    name   = "tag:Name"
    values = ["*a"]
  }
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
  filter {
      name   = "vpc-id"
      values = [data.aws_vpc.current_vpc.id]
  }
}

data "aws_subnet" "public_subnet_b" {
  filter {
    name   = "tag:Name"
    values = ["*b"]
  }
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
  filter {
      name   = "vpc-id"
      values = [data.aws_vpc.current_vpc.id]
  }
}

data "aws_subnet" "public_subnet_c" {
  filter {
    name   = "tag:Name"
    values = ["*c"]
  }
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
  filter {
      name   = "vpc-id"
      values = [data.aws_vpc.current_vpc.id]
  }
}

variable "amazon_linux_ami" {
  default = "ami-006935d9a6773e4ec"
}


variable "route_53_credential_profile" {}
variable "hosted_zone" {}
variable "pem_key" {}
variable "private_hosted_zone_enabled" {}

data "aws_route53_zone" "private_hosted_zone" {
  count = var.private_hosted_zone_enabled == true ? 1 : 0
  name         = var.hosted_zone
  private_zone = true
  provider   = aws.route_53_credential_profile
}

data "aws_route53_zone" "public_hosted_zone" {
  name         = var.hosted_zone
  private_zone = false
  provider   = aws.route_53_credential_profile
}

variable "namespace" {
  default = "monitoring"
}

variable "serviceaccount" {
  default = "loki"
}