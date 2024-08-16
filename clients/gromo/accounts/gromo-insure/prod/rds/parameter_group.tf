# locals {
#   pg_name = format("%s-%s", var.prefix, replace(var.family, ".", "-"))
# }
#
# resource "aws_db_parameter_group" "default" {
#   name        = local.pg_name
#   description = format("%s parameter group", local.pg_name)
#   family      = var.family
#
#   dynamic "parameter" {
#     for_each = var.parameter
#     content {
#       apply_method = parameter.value.apply_method
#       name         = parameter.value.name
#       value        = parameter.value.value
#     }
#   }
#   tags = merge({ Name = var.prefix }, var.tags)
#
#   lifecycle {
#     create_before_destroy = true
#   }
# }
#
#
# module "aws_db_parameter_group" {
#   source = "./"
#   # Family must match RDS instance's engine version.
#   family = "mysql8.0"
#
#   # Prefix for parameter group name.
#   prefix = "authman"
#
#   parameter = [
#     {
#       name  = "character_set_client"
#       value = "utf8"
#     },
#
#     {
#       name  = "character_set_connection"
#       value = "utf8"
#     }
#   ]
# }