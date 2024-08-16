variable "AWS_REGION" {
  type        = string
  description = "Provide region in which to deploy TF code"
}

variable "credentials_profile_name" {
  type        = string
  description = "Name of the AWS credentials profile name to use."
}

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
  filter {
      name   = "vpc-id"
      values = [data.aws_vpc.current_vpc.id]
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
  filter {
      name   = "vpc-id"
      values = [data.aws_vpc.current_vpc.id]
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
  filter {
      name   = "vpc-id"
      values = [data.aws_vpc.current_vpc.id]
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


data "aws_acm_certificate" "acm_cert" {
  domain      = "*.${var.hosted_zone}"
  statuses = ["ISSUED"]
  most_recent = true
}


variable "route_53_credential_profile" {}

