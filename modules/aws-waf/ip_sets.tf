resource "aws_wafv2_ip_set" "office_ip_set" {
  name        = "office_ip_set"
  description = "IP set to allow specific IP addresses"
  scope       = var.scope

  ip_address_version = "IPV4"

  addresses = var.office_ip_set
}
resource "aws_wafv2_ip_set" "data_center_ip_set" {
  name        = "data_center_ip_set"
  description = "IP set to allow specific IP addresses"
  scope       = var.scope

  ip_address_version = "IPV4"

  addresses = var.data_center_ip_set
}
resource "aws_wafv2_ip_set" "other_whitelisted_ip_set" {
  name        = "other_whitelisted_ip_set"
  description = "IP set to allow specific IP addresses"
  scope       = var.scope

  ip_address_version = "IPV4"

  addresses = var.other_whitelisted_ip_set
}

resource "aws_wafv2_ip_set" "aws_ip_set" {
  name        = "aws_ip_set"
  description = "IP set to allow specific IP addresses"
  scope       = var.scope

  ip_address_version = "IPV4"

  addresses = var.aws_ip_set
}
resource "aws_wafv2_ip_set" "external_vendor_ip_set" {
  name        = "external_vendor_ip_set"
  description = "IP set to allow specific IP addresses"
  scope       = var.scope

  ip_address_version = "IPV4"

  addresses = var.external_vendor_ip_set
}

# rule to block specific ips
resource "aws_wafv2_ip_set" "blacklisted_ip_set" {
  name        = "blacklisted_ip_set"
  description = "IP set to block specific IP addresses"
  scope       = var.scope

  ip_address_version = "IPV4"

  addresses = var.blacklisted_ip_set
}