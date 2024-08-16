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

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
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




locals {
  common_tags = {
    Project = "${var.account}_project"
  }
}
variable "domain_name" {
  default = "gromo.net"

}
variable "key_name" {
  default = "gromo-central"
}
variable "ami" {
  default = "ami-0801eb675a338c853"
}
variable "instance_type" {
  default = "t3a.medium"
}