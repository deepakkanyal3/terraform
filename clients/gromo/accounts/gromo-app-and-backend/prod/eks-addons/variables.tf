variable "AWS_REGION" {
  type        = string
  description = "Provide region in which to deploy TF code"
}

variable "credentials_profile_name" {
  type        = string
  description = "Name of the AWS credentials profile name to use."
}

variable "route_53_credential_profile" {}

variable "account" {
  type = string
}

variable "environment" {
  type = string
}


variable "name" {
  type    = string
  default = "eks"
}

data "aws_vpc" "current_vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.account}-vpc-${var.environment}"]
  }
}

data "aws_subnet" "private_subnet_a" {
  filter {
    name   = "tag:Name"
    values = ["*a"]
  }
  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}

data "aws_subnet" "private_subnet_b" {
  filter {
    name   = "tag:Name"
    values = ["*b"]
  }
  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}

data "aws_subnet" "private_subnet_c" {
  filter {
    name   = "tag:Name"
    values = ["*c"]
  }
  filter {
    name   = "tag:Name"
    values = ["*private*"]
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
}


variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

data "aws_caller_identity" "current" {}

locals {
  common_tags = {
    Project = "${var.account}_project"
  }
}

variable "cluster_version" {
  description = "Enter EKS Cluster Version"
}
variable "central_account_cidr" {}

data "aws_eks_cluster" "current_eks" {
  name       = "${var.account}-${var.name}-${var.environment}"
}


variable "hosted_zone" {}


# Find a certificate issued by (not imported into) ACM
data "aws_acm_certificate" "acm_cert" {
  domain      = "*.${var.hosted_zone}"
  types       = ["IMPORTED"]
  statuses = ["ISSUED"]
  most_recent = true
}

variable "indiasales_hosted_zone" {
  default = "indiasales.club"
}


data "aws_acm_certificate" "acm_cert_indiasales" {
  domain      = "*.${var.indiasales_hosted_zone}"
  statuses = ["ISSUED"]
  most_recent = true
}

variable "mygrid_hosted_zone" {
  default = "mygrid.in"
}


data "aws_acm_certificate" "acm_cert_mygrid" {
  domain      = "*.${var.mygrid_hosted_zone}"
  statuses = ["ISSUED"]
  most_recent = true
}