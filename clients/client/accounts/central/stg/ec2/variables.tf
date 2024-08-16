variable "AWS_REGION" {
  type        = string
  default     = "ap-south-1"
  description = "Provide region in which to deploy TF code"
}

variable "credentials_profile_name" {
  type        = string
  default     = "default"
  description = "Name of the AWS credentials profile name to use."
}

variable "account" {
  type = string
  # default = "iopshub-account"
}

variable "environment" {
  type = string
  # default = "stg"
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
        name   = "vpc-id"
        values = [data.aws_vpc.current_vpc.id]
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
        name   = "vpc-id"
        values = [data.aws_vpc.current_vpc.id]
      }
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

data "aws_subnet" "private_subnet_a" {
  filter {
    name   = "tag:Name"
    values = ["*a"]
  }
  filter {
        name   = "vpc-id"
        values = [data.aws_vpc.current_vpc.id]
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
        name   = "vpc-id"
        values = [data.aws_vpc.current_vpc.id]
    }
  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}

variable "amazon_linux_ami" {
  default = "ami-006935d9a6773e4ec"
}
variable "ubuntu_linux_ami" {
  default = "ami-007020fd9c84e18c7"
}

variable "create" {
  description = "Controls if resources should be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "delete_protection" {
  description = "A boolean flag indicating whether it is possible to delete the firewall. Defaults to `true`"
  type        = bool
  default     = true
}

variable "description" {
  description = "A friendly description of the firewall"
  type        = string
  default     = ""
}

variable "encryption_configuration" {
  description = "KMS encryption configuration settings"
  type        = any
  default     = {}
}


variable "vpc_id" {
  description = "The unique identifier of the VPC where AWS Network Firewall should create the firewall"
  type        = string
  default     = "vpc-0ac6934dcc1bb7083"
}

variable "pem_key" {}