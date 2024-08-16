#**************************************************************************************
# ENV & Tags
#**************************************************************************************

variable "environment" {
  type        = string
  description = "Enter the Environment in which to be deplyed"
}
variable "account" {}
variable "tags" {}
variable "hosted_zone" {}

terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.vpc_provider, aws.route53_provider]
    }
  }
}
data "aws_caller_identity" "current" {}