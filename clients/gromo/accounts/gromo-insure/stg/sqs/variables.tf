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

variable "sqs" {
  default = "insurance-lead-update"
}

variable "sqs1" {
  default = "pos-details-update"
}

variable "sqs2" {
  default = "pos-update-from-insurance"
}

variable "sqs3" {
  default = "pos-update-from-gp"
}

variable "sqs4" {
  default = "update-create-data-on-crm"
}
variable "sqs5" {
  default = "update-gp-from-pos"
}
variable "sqs6" {
  default = "mi-sync-pos"
}
variable "sqs7" {
  default = "pos-create"
}
variable "sqs8" {
  default = "update-policy-issued-count"
}
variable "sqs9" {
  default = "reminder-from-insurance"
}
variable "sqs10" {
  default = "update-vehicle-data"
}
variable "sqs11" {
  default = "offline-motor-form-submit"
}
variable "sqs12" {
  default = "policy-queue"
}

variable "sqs13" {
  default = "hi-lead-update-status"
}

variable "sqs14" {
  default = "create-lead-response-from-app-backend"
}

variable "sqs15" {
  default = "create-lead-from-hi"
}
variable "sqs16" {
  default = "update-lead-from-hi"
}

variable "sqs17" {
  default = "update-crm-lead-id"
}

variable "sqs18" {
  default = "offline-create-zoho-ticket"
}

variable "sqs19" {
  default = "policy-queue-tw"
}

variable "sqs20" {
  default = "pos-backend-retry"
}

variable "sqs21" {
  default = "lead-status-queue"
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