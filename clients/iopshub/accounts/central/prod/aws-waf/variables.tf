variable "account" {
  type = string
  # default = "iopshub-account"
}

variable "environment" {
  type = string
}
data "aws_caller_identity" "current" {}

locals {
  common_tags = {
    Project = "${var.account}_project"
  }
}
variable "scope" {
  type = string
  default = "REGIONAL"
}

############
variable "whitelist_rule_group_name" {
  description = "The name of the rule group"
  type        = string
  default = "ip_whitelist_rule_group"
}

variable "whitelist_rule_group_capacity" {
  description = "The capacity of the rule group"
  type        = number
  default = 100
}
variable "allow_geo_location_rule_group_capacity" {
  description = "The capacity of the rule group"
  type        = number
  default = 100
}
variable "block_geo_location_rule_group_capacity" {
  description = "The capacity of the rule group"
  type        = number
  default = 100
}
variable "block_geo_location" {
  description = "A list of geo locations to block"
  type        = list(string)
  default = ["US"]
}
variable "allow_geo_location" {
  description = "A list of geo locations to allow"
  type        = list(string)
  default = ["CD", "IN"]
}
variable "blacklist_rule_group_name" {
  description = "The name of the rule group"
  type        = string
  default = "ip_blacklist_rule_group"
}

variable "blacklist_rule_group_capacity" {
  description = "The capacity of the rule group"
  type        = number
  default = 100
}


variable "blacklisted_ip_set" {
  description = "A list of IP addresses to block"
  type        = list(string)
  default = ["1.2.3.2/32", "5.6.7.8/32"]
}
variable "office_ip_set" {
  description = "A list of IP addresses to allow"
  type        = list(string)
  default = ["192.0.2.0/24"]
}
variable "data_center_ip_set" {
  description = "A list of IP addresses to allow"
  type        = list(string)
  default = ["198.52.100.0/24"]
}
variable "other_whitelisted_ip_set" {
  description = "A list of IP addresses to allow"
  type        = list(string)
  default = ["198.55.100.0/24"]
}
variable "aws_ip_set" {
  description = "A list of IP addresses to allow"
  type        = list(string)
  default = ["198.51.100.0/24"]
}
variable "external_vendor_ip_set" {
  description = "A list of IP addresses to allow"
  type        = list(string)
  default = ["198.50.100.0/24"]

}
variable "rate_limit" {
  description = "The maximum number of requests allowed from a single IP address in a five-minute period."
  type        = number
  default     = 2000
}