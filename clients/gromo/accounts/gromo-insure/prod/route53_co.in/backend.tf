terraform {
  backend "s3" {
    bucket  = "gromo-terraform-state-bucket"
    key     = "account/gromo-insure/prod/route53_co.in/terraform.tfstate"
    region  = "ap-south-1"
    profile = "gromo-central"
  }
}