terraform {
  backend "s3" {
    bucket  = "gromo-terraform-state-bucket"
    key     = "account/gromo-cloudkeeper/prod/organization-unit/terraform.tfstate"
    region  = "ap-south-1"
    profile = "gromo-central"
    
  }
}