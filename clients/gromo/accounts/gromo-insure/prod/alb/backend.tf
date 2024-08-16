terraform {
  backend "s3" {
    bucket  = "gromo-terraform-state-bucket"
    key     = "account/gromo-insure/prod/alb/terraform.tfstate"
    region  = "ap-south-1"
    profile = "gromo-central"
  }
}

