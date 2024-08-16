terraform {
  backend "s3" {
    bucket  = "gromo-terraform-state-bucket"
    key     = "account/insurance/dev/loki/terraform.tfstate"
    region  = "ap-south-1"
    profile = "gromo-central"
  }
}
