variable "environment" {
  type        = string
  description = "Enter the Environment in which to be deplyed"
}
variable "account" {}

terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.vpc_provider, aws.second_provider]
    }
  }
}

variable "tags" {}
# data "aws_caller_identity" "current" {}