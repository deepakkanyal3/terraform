terraform {
  backend "s3" {
    bucket  = "gromo-terraform-state-bucket"
    key     = "account/gromo-insure/stg/sqs/terraform.tfstate"
    region  = "ap-south-1"
    profile = "gromo-central"
  }
}


