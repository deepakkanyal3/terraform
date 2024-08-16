terraform {
  backend "s3" {
    bucket  = "iopshub-terraform-state-bucket"
    key     = "account/iopshub/central/aws-ses/terraform.tfstate"
    region  = "ap-south-1"
    profile = "default"
    
  }
}
