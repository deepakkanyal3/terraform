terraform {
  backend "s3" {
    bucket  = "gromo-terraform-state-bucket"
    key     = "account/gromo-central/prod/eks/terraform.tfstate"
    region  = "ap-south-1"
    profile = "gromo-central"
  }
}
