# locals {
#   num_azs  = 3
#   account_id = data.aws_caller_identity.current.account_id
#   name       = "network-firewall"
#   #azs      = slice(data.aws_availability_zones.available.names, 0, local.num_azs)
# }

# module "firewall" {
#   source = "../../../../../../modules/network-firewall/firewall"

#   create = var.create

#   # Firewall
#   delete_protection                 = false
#   description                       = var.description
#   encryption_configuration          = var.encryption_configuration
#   firewall_policy_arn               = var.create_policy ? module.policy.arn : var.firewall_policy_arn
#   firewall_policy_change_protection = var.firewall_policy_change_protection
#   name                              = var.name
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
#   }
#   # subnet_mapping = { for i in range(0, local.num_azs) :
#   #   "subnet-${i}" => {
#   #     subnet_id       = data.aws_subnet.private_subnet_a.id
#   #     ip_address_type = "IPV4"
#   #   }
#   # }
#   vpc_id                            = data.aws_vpc.current_vpc.id

#   tags                   = local.common_tags
#   account = var.account
#   environment = var.environment
# }

# module "policy" {
#   source = "../../../../../../modules/network-firewall/policy"

#   create = var.create && var.create_policy

#   # Policy
#   description                        = "test-policy"
#   encryption_configuration           = var.policy_encryption_configuration
#   stateful_default_actions           = var.policy_stateful_default_actions
#   stateful_engine_options            = var.policy_stateful_engine_options
#   stateful_rule_group_reference      = var.policy_stateful_rule_group_reference
#   stateless_custom_action            = var.policy_stateless_custom_action
#   stateless_default_actions          = ["aws:forward_to_sfe"]
#   stateless_fragment_default_actions = ["aws:pass"]
#   stateless_rule_group_reference     = var.policy_stateless_rule_group_reference
#   name                               = var.name

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


# # module "network_firewall_rule_group_stateful" {
# #   source = "../../../../../../modules/network-firewall/rule-group"

# #   name        = "${local.name}-stateful"
# #   description = "Stateful Inspection for denying access to a domain"
# #   type        = "STATEFUL"
# #   capacity    = 100

# #   rule_group = {
# #     rules_source = {
# #       rules_source_list = {
# #         generated_rules_type = "DENYLIST"
# #         target_types         = ["HTTP_HOST"]
# #         targets              = ["test.example.com"]
# #       }
# #     }
# #   }

# #   # Resource Policy
# #   create_resource_policy     = true
# #   attach_resource_policy     = true
# #   resource_policy_principals = ["arn:aws:iam::${local.account_id}:root"]

# #   tags                   = local.common_tags
# #   account = var.account
# #   environment = var.environment
# # }

# # module "network_firewall_rule_group_stateless" {
# #   source = "../../../../../../modules/network-firewall/rule-group"

# #   name        = "${local.name}-stateless"
# #   description = "Stateless Inspection with a Custom Action"
# #   type        = "STATELESS"
# #   capacity    = 100

# #   rule_group = {
# #     rules_source = {
# #       stateless_rules_and_custom_actions = {
# #         custom_action = [{
# #           action_definition = {
# #             publish_metric_action = {
# #               dimension = [{
# #                 value = "2"
# #               }]
# #             }
# #           }
# #           action_name = "MetricsAction"
# #         }]
# #         stateless_rule = [{
# #           priority = 1
# #           rule_definition = {
# #             actions = ["aws:pass", "MetricsAction"]
# #             match_attributes = {
# #               source = [{
# #                 address_definition = "0.0.0.0/0"
# #               }]
# #               source_port = [{
# #                 from_port = 443
# #                 to_port   = 443
# #               }]
# #               destination = [{
# #                 address_definition = "0.0.0.0/0"
# #               }]
# #               destination_port = [{
# #                 from_port = 443
# #                 to_port   = 443
# #               }]
# #               protocols = [6]
# #               tcp_flag = [{
# #                 flags = ["SYN"]
# #                 masks = ["SYN", "ACK"]
# #               }]
# #             }
# #           }
# #         }]
# #       }
# #     }
# #   }

# #   # Resource Policy
# #   create_resource_policy     = true
# #   attach_resource_policy     = true
# #   resource_policy_principals = ["arn:aws:iam::${local.account_id}:root"]

# #   tags                   = local.common_tags
# #   account = var.account
# #   environment = var.environment
# # }