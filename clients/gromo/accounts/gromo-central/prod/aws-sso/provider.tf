terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.AWS_REGION
  profile = var.credentials_profile_name
}

provider "aws" {
  region  = var.AWS_REGION
  profile = "gromo-app-backend"
  alias   = "gromo-app-backend"
}

provider "aws" {
  region  = var.AWS_REGION
  profile = "gromo-insure"
  alias   = "gromo-insure"
}