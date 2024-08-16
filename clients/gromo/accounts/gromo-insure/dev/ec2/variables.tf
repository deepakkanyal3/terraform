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

variable "appname1" {
  default = "motorinsurance"
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
  default     = "10.130.0.0/16"
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
   default = "sg-08bb3d092cb4d619d"
 }

 variable "public_alb_sg" {
   type    = string
   default = "sg-0f36dc91161868d1c"
 }


variable "amazon_linux_ami" {
  default = "ami-077885f59ecb77b84"
}
variable "central_account_cidr" {}
variable "pem_key" {}
