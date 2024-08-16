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
  default = "health"
}

variable "vpc_cidr" {
  type        = string
}

variable "jenkins_server_cidr" {
  type        = string
  default     = "172.31.0.0/16"
}

variable "vpc_cidr_insure" {
  type        = string
  default     = "10.120.0.0/16"
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

data "aws_subnet" "public_subnet_c" {
  filter {
    name   = "tag:Name"
    values = ["*c"]
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

data "aws_subnet" "private_subnet_c" {
  filter {
    name   = "tag:Name"
    values = ["*c"]
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

variable "private_alb_sg" {
  type    = string
  default = "sg-0a733b7563d5d11e9"
}

variable "public_alb_sg" {
  type    = string
  default = "sg-0f598576667a856d4"
}

variable "mi_nlb_sg" {
  type    = string
  default = "sg-0779a465bbae531fd"
}


variable "amazon_linux_ami" {
  default = "ami-0287a05f0ef0e9d9a"
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