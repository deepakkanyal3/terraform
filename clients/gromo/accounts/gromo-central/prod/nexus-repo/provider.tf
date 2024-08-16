terraform {
  required_providers {
    nexus = {
      source = "datadrivers/nexus"
      version = "2.2.0"
    }
  }
}

provider "nexus" {
  insecure = true
  password = var.nexus_password
  url      = var.nexus_url
  username = var.nexus_username
}
