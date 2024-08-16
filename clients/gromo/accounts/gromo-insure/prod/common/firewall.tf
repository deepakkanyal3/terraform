#  locals {
# #   num_azs  = 3
#    account_id = data.aws_caller_identity.current.account_id
#     name       = "network-firewall"
# #   #azs      = slice(data.aws_availability_zones.available.names, 0, local.num_azs)
#  }

# module "firewall" {
#   source = "../../../../../../modules/network-firewall/firewall"

#   create = var.create

#   # Firewall
#   delete_protection                 = false
#   description                       = var.description
#   encryption_configuration          = var.encryption_configuration
#   firewall_policy_arn               = var.create_policy ? module.policy.arn : var.firewall_policy_arn
#   firewall_policy_change_protection = var.firewall_policy_change_protection
#   name                              = "${var.account}-${var.name}-${var.environment}"
#   subnet_change_protection          = false
#   subnet_mapping = {
#     subnet1 = {
#       subnet_id       = data.aws_subnet.firewall_subnet_a.id
#       ip_address_type = "IPV4"
#     }
#     subnet2 = {
#       subnet_id       = data.aws_subnet.firewall_subnet_b.id
#       ip_address_type = "IPV4"
#     }
#     subnet3 = {
#       subnet_id       = data.aws_subnet.firewall_subnet_c.id
#       ip_address_type = "IPV4"
#     }
#   }
#   vpc_id                            = data.aws_vpc.current_vpc.id

#   tags                   = local.common_tags
#   account = var.account
#   environment = var.environment
# }

# module "policy" {
#   source = "../../../../../../modules/network-firewall/policy"

#   create = var.create && var.create_policy

#   # Policy
#   description                        = "This policy contains stateful aws manages rules"
#   encryption_configuration           = var.policy_encryption_configuration
#   #rule_order                         = "DEFAULT_ACTION_ORDER"
#   #stateful_default_actions           = ["aws:alert"]
#   stateful_engine_options            = var.policy_stateful_engine_options
#   stateful_rule_group_reference    = [
#     {
#       resource_arn = "${var.aws_network_firewall_prefix}:${var.AWS_REGION}:${var.aws_stateful_rule_prefix}/AbusedLegitMalwareDomainsActionOrder"
#       override = {
#             action = "DROP_TO_ALERT"
#         }
#     },
#     {
#       resource_arn = "${var.aws_network_firewall_prefix}:${var.AWS_REGION}:${var.aws_stateful_rule_prefix}/MalwareDomainsActionOrder"
#       override = {
#             action = "DROP_TO_ALERT"
#         }
#     },
#     {
#       resource_arn = "${var.aws_network_firewall_prefix}:${var.AWS_REGION}:${var.aws_stateful_rule_prefix}/ThreatSignaturesDoSActionOrder"
#       override = {
#             action = "DROP_TO_ALERT"
#         }
#     },
#     {
#       resource_arn = "${var.aws_network_firewall_prefix}:${var.AWS_REGION}:${var.aws_stateful_rule_prefix}/ThreatSignaturesExploitsActionOrder"
#       override = {
#             action = "DROP_TO_ALERT"
#         }
#     },
#     {
#       resource_arn = "${var.aws_network_firewall_prefix}:${var.AWS_REGION}:${var.aws_stateful_rule_prefix}/ThreatSignaturesMalwareCoinminingActionOrder"
#       override = {
#             action = "DROP_TO_ALERT"
#         }
#     },
#     {
#       resource_arn = "${var.aws_network_firewall_prefix}:${var.AWS_REGION}:${var.aws_stateful_rule_prefix}/ThreatSignaturesMalwareActionOrder"
#       override = {
#             action = "DROP_TO_ALERT"
#         }
#     },
#     {
#       resource_arn = "${var.aws_network_firewall_prefix}:${var.AWS_REGION}:${var.aws_stateful_rule_prefix}/ThreatSignaturesBotnetWebActionOrder"
#       override = {
#             action = "DROP_TO_ALERT"
#         }
#     },
#     {
#       resource_arn = "${var.aws_network_firewall_prefix}:${var.AWS_REGION}:${var.aws_stateful_rule_prefix}/ThreatSignaturesPhishingActionOrder"
#       override = {
#             action = "DROP_TO_ALERT"
#         }
#     },
#     {
#       resource_arn = "${var.aws_network_firewall_prefix}:${var.AWS_REGION}:${var.aws_stateful_rule_prefix}/ThreatSignaturesMalwareMobileActionOrder"
#       override = {
#             action = "DROP_TO_ALERT"
#         }
#     }
#   ]
#   stateless_custom_action            = var.policy_stateless_custom_action
#   stateless_default_actions          = ["aws:pass"]
#   stateless_fragment_default_actions = ["aws:pass"]
#   stateless_rule_group_reference     = var.policy_stateless_rule_group_reference
#   name                               = "${var.account}-${var.name}-${var.environment}"


#   # Resource policy
#   create_resource_policy     = var.create_policy_resource_policy
#   resource_policy_actions    = var.policy_resource_policy_actions
#   resource_policy_principals = var.policy_resource_policy_principals
#   attach_resource_policy     = var.policy_attach_resource_policy
#   resource_policy            = var.policy_resource_policy

#   # RAM resource association
#   ram_resource_associations = var.policy_ram_resource_associations

#   tags                   = local.common_tags
#   account = var.account
#   environment = var.environment
  
# }