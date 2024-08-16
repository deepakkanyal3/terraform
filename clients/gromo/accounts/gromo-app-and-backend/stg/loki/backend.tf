terraform {
  backend "s3" {
    bucket  = "gromo-app-backend-stg-terraform-state-bucket"
    key     = "account/gromo-app-and-backend/stg/loki/terraform.tfstate"
    region  = "ap-south-1"
    profile = "gromo-app-backend-staging"
  }
}