terraform {
  backend "s3" {
    bucket  = "gromo-app-backend-terraform-state-bucket"
    key     = "account/gromo-app-and-backend/prod/loki/terraform.tfstate"
    region  = "ap-south-1"
    profile = "gromo-app-backend"
  }
}
