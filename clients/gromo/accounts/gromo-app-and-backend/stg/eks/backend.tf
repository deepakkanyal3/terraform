terraform {
  backend "s3" {
    bucket  = "gromo-app-backend-stg-terraform-state-bucket"
    key     = "account/gromo-app-and-backend/stg/eks/terraform.tfstate"
    region  = "ap-south-1"
    profile = "brands-stg"
  }
}
