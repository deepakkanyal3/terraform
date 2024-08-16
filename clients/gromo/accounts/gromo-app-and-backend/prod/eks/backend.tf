terraform {
  backend "s3" {
    bucket  = "gromo-app-backend-terraform-state-bucket"
    key     = "account/gromo-app-and-backend/prod/eks/terraform.tfstate"
    region  = "ap-south-1"
    profile = "brands-prod"
  }

}
