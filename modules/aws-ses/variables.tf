variable hosted_zone{}
terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.ses, aws.route53]
    }
  }
}