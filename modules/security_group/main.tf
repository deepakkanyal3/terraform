#**************************************************************************************************
# Security Group
#**************************************************************************************************
locals {
  ingress_cidr      = var.ingress_cidr
  ingress_self      = var.ingress_self
  ingress_source-sg = var.ingress_source-sg
  egress_cidr       = var.egress_cidr
  egress_self       = var.egress_self
  egress_source-sg  = var.egress_source-sg
}
resource "aws_security_group" "security_group" {
  name   = "${var.account}_${var.name}_${var.environment}_sg"
  vpc_id = var.vpc_id
  tags   = merge(

    var.tags,
    {
      Account         = var.account
      Environment     = var.environment
      CreatedBy       = data.aws_caller_identity.current.user_id
      CreatedByArn    = data.aws_caller_identity.current.arn
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
    },
    {
      Name = "${var.account}_${var.name}_${var.environment}_sg"
    }
  )
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"],
    ]
  }
}
# Ingress - CIDR
resource "aws_security_group_rule" "ingress_cidrs" {
  count             = length(local.ingress_cidr)
  description       = local.ingress_cidr[count.index].description
  from_port         = local.ingress_cidr[count.index].from_port
  to_port           = local.ingress_cidr[count.index].to_port
  protocol          = local.ingress_cidr[count.index].protocol
  type              = local.ingress_cidr[count.index].type
  security_group_id = aws_security_group.security_group.id
  cidr_blocks       = [local.ingress_cidr[count.index].cidr_block]
}

# Ingress - Self
resource "aws_security_group_rule" "ingress_self" {
  count             = length(local.ingress_self)
  description       = local.ingress_self[count.index].description
  from_port         = local.ingress_self[count.index].from_port
  to_port           = local.ingress_self[count.index].to_port
  protocol          = local.ingress_self[count.index].protocol
  security_group_id = aws_security_group.security_group.id
  self              = local.ingress_self[count.index].self
  type              = local.ingress_self[count.index].type
}

# Ingress - Source-SG
resource "aws_security_group_rule" "ingress_source-sg" {
  count                    = length(local.ingress_source-sg)
  description              = local.ingress_source-sg[count.index].description
  from_port                = local.ingress_source-sg[count.index].from_port
  to_port                  = local.ingress_source-sg[count.index].to_port
  protocol                 = local.ingress_source-sg[count.index].protocol
  security_group_id        = aws_security_group.security_group.id
  source_security_group_id = local.ingress_source-sg[count.index].source_security_group_id
  type                     = local.ingress_source-sg[count.index].type
}

# Egress - CIDR
resource "aws_security_group_rule" "egress_cidrs" {
  count             = length(local.egress_cidr)
  description       = local.egress_cidr[count.index].description
  from_port         = local.egress_cidr[count.index].from_port
  to_port           = local.egress_cidr[count.index].to_port
  protocol          = local.egress_cidr[count.index].protocol
  security_group_id = aws_security_group.security_group.id
  type              = local.egress_cidr[count.index].type
  cidr_blocks       = [local.egress_cidr[count.index].cidr_block]
}
# Egress - Self
resource "aws_security_group_rule" "egress_self" {
  count             = length(local.egress_self)
  description       = local.egress_self[count.index].description
  from_port         = local.egress_self[count.index].from_port
  to_port           = local.egress_self[count.index].to_port
  protocol          = local.egress_self[count.index].protocol
  security_group_id = aws_security_group.security_group.id
  self              = local.egress_self[count.index].self
  type              = local.egress_self[count.index].type
}
# Egress - Source-SG
resource "aws_security_group_rule" "egress_source-sg" {
  count                    = length(local.egress_source-sg)
  description              = local.egress_source-sg[count.index].description
  from_port                = local.egress_source-sg[count.index].from_port
  to_port                  = local.egress_source-sg[count.index].to_port
  protocol                 = local.egress_source-sg[count.index].protocol
  security_group_id        = aws_security_group.security_group.id
  source_security_group_id = local.egress_source-sg[count.index].source_security_group_id
  type                     = local.egress_source-sg[count.index].type
}