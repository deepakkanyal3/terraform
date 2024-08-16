resource "aws_security_group" "vpc_endpoint" {
  name              = "${var.account}-vpc-endpoint-${var.environment}"
  vpc_id            = var.vpc_id
  description = "${var.account}-vpc-endpoint-${var.environment}"
  tags = merge(
    {
      "Name" = "${var.account}-vpc-endpoint-${var.environment}"
    },
    {
      Account         = var.account
      Environment     = var.environment
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
    },
    var.tags
  )

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"]
    ]
  }
}

resource "aws_security_group_rule" "vpc_endpoint_ingress" {
  count             = length(var.ingress_rules)
  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  description       = var.ingress_rules[count.index].description
  security_group_id = aws_security_group.vpc_endpoint.id
}

resource "aws_vpc_endpoint" "vpc_gateway_endpoint" {
  count             = length(var.gateway_endpoint_list)
  vpc_id            = var.vpc_id
  service_name      = var.gateway_endpoint_list[count.index].endpoint
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.route_table_ids
  tags = merge(
    {
      "Name" = "${var.account}-${var.gateway_endpoint_list[count.index].name}-gateway-${var.environment}"
    },
    {
      Account         = var.account
      Environment     = var.environment
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
    },
    var.tags
  )

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"]
    ]
  }
}

resource "aws_vpc_endpoint" "vpc_interface_endpoint" {
  count             = length(var.interface_endpoint_list)
  vpc_id            = var.vpc_id
  service_name      = var.interface_endpoint_list[count.index].endpoint
  vpc_endpoint_type = "Interface"
  security_group_ids = [aws_security_group.vpc_endpoint.id]
  subnet_ids        = var.subnet_ids
  private_dns_enabled = try(var.interface_endpoint_list[count.index].private_dns_enabled, true)

  # dynamic "dns_options" {
  #   for_each = var.interface_endpoint_list[count.index].private_dns_only_for_inbound_resolver_endpoint

  #   content {
  #     dns_options  = {
  #       private_dns_only_for_inbound_resolver_endpoint = var.interface_endpoint_list[count.index].private_dns_only_for_inbound_resolver_endpoint
  #     }
  #   }
  # }
  tags = merge(
    {
      "Name" = "${var.account}-${var.interface_endpoint_list[count.index].name}-interface-${var.environment}"
    },
    {
      Account         = var.account
      Environment     = var.environment
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
    },
    var.tags
  )

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"]
    ]
  }
}
