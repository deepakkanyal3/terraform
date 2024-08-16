variable "name" {
  description = "The name of the WAF WebACL"
  type        = string
  default = "aws-waf-v2-test"
}

# variable "metric_name"
variable "scope" {
  description = "Specifies whether this is for an AWS CloudFront distribution or regional resources"
  type        = string
  default     = "REGIONAL"
}

variable "whitelist_rule_group_name" {
  description = "The name of the rule group"
  type        = string
}

variable "whitelist_rule_group_capacity" {
  description = "The capacity of the rule group"
  type        = number
}
variable "allow_geo_location_rule_group_capacity" {
  description = "The capacity of the rule group"
  type        = number
}
variable "block_geo_location_rule_group_capacity" {
  description = "The capacity of the rule group"
  type        = number
}
variable "block_geo_location" {
  description = "A list of geo locations to block"
  type        = list(string)
}
variable "allow_geo_location" {
  description = "A list of geo locations to allow"
  type        = list(string)
}
variable "blacklist_rule_group_name" {
  description = "The name of the rule group"
  type        = string
}

variable "blacklist_rule_group_capacity" {
  description = "The capacity of the rule group"
  type        = number
}


variable "blacklisted_ip_set" {
  description = "A list of IP addresses to block"
  type        = list(string)
}
variable "office_ip_set" {
  description = "A list of IP addresses to allow"
  type        = list(string)
}
variable "data_center_ip_set" {
  description = "A list of IP addresses to allow"
  type        = list(string)
}
variable "other_whitelisted_ip_set" {
  description = "A list of IP addresses to allow"
  type        = list(string)
}
variable "aws_ip_set" {
  description = "A list of IP addresses to allow"
  type        = list(string)
}
variable "external_vendor_ip_set" {
  description = "A list of IP addresses to allow"
  type        = list(string)
}
variable "rate_limit" {
  description = "The maximum number of requests allowed from a single IP address in a five-minute period."
  type        = number
  default     = 2000
}
data "aws_caller_identity" "current" {}
variable "environment" {
  type        = string
  description = "Enter the Environment in which to be deplyed"
}
variable "account" {}
variable "tags" {}