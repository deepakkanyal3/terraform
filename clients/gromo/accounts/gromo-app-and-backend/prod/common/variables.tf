variable "AWS_REGION" {
  type        = string
  # default     = "ap-south-1"
  description = "Provide region in which to deploy TF code"
}

variable "credentials_profile_name" {
  type        = string
  # default     = "gromo-app-backend"
  description = "Name of the AWS credentials profile name to use."
}



variable "account" {
  type = string
  # default = "gromo-app-and-backend"
}

variable "environment" {
  type = string
  # default = "stg"
}

variable "vpc_cidr" {
  type = string
  # default = "10.0.16.0/20"
}

variable "brands_vpc_cidr" {
  type = string
  default = "172.31.0.0/16"
}

variable "azs" {
  type = list(string)
  # default = [ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]
}

data "aws_caller_identity" "current" {}

locals {
  common_tags = {
    Project = "${var.account}_project"
  }
}

variable "hosted_zone" {}
# variable "route_53_credential_profile" {}


# Network Firewall
variable "create" {
  description = "Controls if resources should be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "delete_protection" {
  description = "A boolean flag indicating whether it is possible to delete the firewall. Defaults to `true`"
  type        = bool
  default     = true
}

variable "description" {
  description = "A friendly description of the firewall"
  type        = string
  default     = ""
}

variable "encryption_configuration" {
  description = "KMS encryption configuration settings"
  type        = any
  default     = {}
}

variable "firewall_policy_arn" {
  description = "The ARN of the Firewall Policy to use"
  type        = string
  default     = ""
}

variable "firewall_policy_change_protection" {
  description = "A boolean flag indicating whether it is possible to change the associated firewall policy. Defaults to `false`"
  type        = bool
  default     = null
}

variable "name" {
  description = "A friendly name of the firewall"
  type        = string
  default     = "firewall"
}

variable "subnet_change_protection" {
  description = "A boolean flag indicating whether it is possible to change the associated subnet(s). Defaults to `true`"
  type        = bool
  default     = true
}

variable "subnet_mapping" {
  description = "Set of configuration blocks describing the public subnets. Each subnet must belong to a different Availability Zone in the VPC. AWS Network Firewall creates a firewall endpoint in each subnet"
  type        = any
  default     = {}
}

################################################################################
# Firewall Policy
################################################################################

variable "create_policy" {
  description = "Controls if policy should be created"
  type        = bool
  default     = true
}

variable "policy_description" {
  description = "A friendly description of the firewall policy"
  type        = string
  default     = null
}

variable "policy_encryption_configuration" {
  description = "KMS encryption configuration settings"
  type        = any
  default     = {}
}

variable "policy_stateful_default_actions" {
  description = "Set of actions to take on a packet if it does not match any stateful rules in the policy. This can only be specified if the policy has a `stateful_engine_options` block with a rule_order value of `STRICT_ORDER`. You can specify one of either or neither values of `aws:drop_strict` or `aws:drop_established`, as well as any combination of `aws:alert_strict` and `aws:alert_established`"
  type        = list(string)
  default     = []
}

variable "policy_stateful_engine_options" {
  description = "A configuration block that defines options on how the policy handles stateful rules. See [Stateful Engine Options](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_firewall_policy#stateful-engine-options) for details"
  type        = any
  default     = {}
}

variable "policy_stateful_rule_group_reference" {
  description = "Set of configuration blocks containing references to the stateful rule groups that are used in the policy. See [Stateful Rule Group Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_firewall_policy#stateful-rule-group-reference) for details"
  type        = any
  default     = {}
}

variable "policy_stateless_custom_action" {
  description = "Set of configuration blocks describing the custom action definitions that are available for use in the firewall policy's `stateless_default_actions`"
  type        = any
  default     = {}
}

variable "policy_stateless_default_actions" {
  description = "Set of actions to take on a packet if it does not match any of the stateless rules in the policy. You must specify one of the standard actions including: `aws:drop`, `aws:pass`, or `aws:forward_to_sfe`"
  type        = list(string)
  default     = ["aws:pass"]
}

variable "policy_stateless_fragment_default_actions" {
  description = "Set of actions to take on a fragmented packet if it does not match any of the stateless rules in the policy. You must specify one of the standard actions including: `aws:drop`, `aws:pass`, or `aws:forward_to_sfe`"
  type        = list(string)
  default     = ["aws:pass"]
}

variable "policy_stateless_rule_group_reference" {
  description = "Set of configuration blocks containing references to the stateless rule groups that are used in the policy. See [Stateless Rule Group Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_firewall_policy#stateless-rule-group-reference) for details"
  type        = any
  default     = {}
}

variable "policy_name" {
  description = "A friendly name of the firewall policy"
  type        = string
  default     = ""
}

variable "policy_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

# Resource Policy
variable "create_policy_resource_policy" {
  description = "Controls if a resource policy should be created"
  type        = bool
  default     = false
}

variable "policy_resource_policy_actions" {
  description = "A list of IAM actions allowed in the resource policy"
  type        = list(string)
  default     = []
}

variable "policy_resource_policy_principals" {
  description = "A list of IAM principals allowed in the resource policy"
  type        = list(string)
  default     = []
}

variable "policy_attach_resource_policy" {
  description = "Controls if a resource policy should be attached to the firewall policy"
  type        = bool
  default     = false
}

variable "policy_resource_policy" {
  description = "The policy JSON to use for the resource policy; required when `create_resource_policy` is `false`"
  type        = string
  default     = ""
}

# RAM Resource Association
variable "policy_ram_resource_associations" {
  description = "A map of RAM resource associations for the created firewall policy"
  type        = map(string)
  default     = {}
}

variable "aws_network_firewall_prefix" {
  description = "ARN prefix for AWS managed stateful rulegroups"
  default     = "arn:aws:network-firewall"
}

variable "aws_stateful_rule_prefix" {
  description = "ARN prefix for AWS managed stateful rulegroups"
  default     = "aws-managed:stateful-rulegroup"
}

