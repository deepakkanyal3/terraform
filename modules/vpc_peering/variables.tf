terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.requestor, aws.acceptor]
    }
  }
}
variable "account" {}

variable "environment" {}

data "aws_vpc" "requestor_vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.account}-vpc-${var.environment}"]
  }
}

variable "tags" {}

variable "aws_region_acceptor_id" {}

variable "acceptor_vpc_id" {}





data "aws_route_tables" "requestor" {
  provider = aws.requestor
  vpc_id   = data.aws_vpc.requestor_vpc.id
}

data "aws_vpc" "acceptor" {
  provider = aws.acceptor
  id       = var.acceptor_vpc_id
}

data "aws_route_tables" "acceptor" {
  provider = aws.acceptor
  vpc_id   = data.aws_vpc.acceptor.id
}

data "aws_route_tables" "requestor_not_needed" {
  provider = aws.requestor
  vpc_id   = data.aws_vpc.requestor_vpc.id
  filter {
    name   = "tag:Name"
    values = ["igw-route"]
  }
}

data "aws_route_tables" "acceptor_not_needed" {
  provider = aws.acceptor
  vpc_id   = data.aws_vpc.acceptor.id
  filter {
    name   = "tag:Name"
    values = ["igw-route"]
  }
}

data "aws_route_tables" "requestor_default_route_table" {
  provider = aws.requestor
  vpc_id   = data.aws_vpc.requestor_vpc.id
  filter {
    name   = "tag:Name"
    values = ["Do Not Use It"]
  }
}

data "aws_route_tables" "acceptor_default_route_table" {
  provider = aws.acceptor
  vpc_id   = data.aws_vpc.acceptor.id
  filter {
    name   = "tag:Name"
    values = ["Do Not Use It"]
  }
}


locals {
  acceptor_route_tables = sort(setsubtract(setsubtract(data.aws_route_tables.acceptor.ids, data.aws_route_tables.acceptor_not_needed.ids), data.aws_route_tables.acceptor_default_route_table.ids))
  requestor_route_tables = sort(setsubtract(setsubtract(data.aws_route_tables.requestor.ids, data.aws_route_tables.requestor_not_needed.ids), data.aws_route_tables.requestor_default_route_table.ids))
}






data "aws_caller_identity" "peer" {
  provider = aws.acceptor
}