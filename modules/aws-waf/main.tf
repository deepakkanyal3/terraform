# web acl resources
resource "aws_wafv2_web_acl" "aws-waf-v2" {
  name        = var.name
  description = "Web ACL using a self-managed rule group"
  scope       = var.scope

  default_action {
    allow {}
  }
  rule {
    name     = "ip_whitelist-rule-group"
    priority = 1

    override_action {
      none {}
    }
    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.whitelist_rule_group.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "self-managed-rule-group"
      sampled_requests_enabled   = true
    }
  }
    rule {
    name     = "ip_blacklist-rule-group"
    priority = 2

    override_action {
      none {}
    }
    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.blacklist_rule_group.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "self-managed-rule-group"
      sampled_requests_enabled   = true
    }
  }
    rule {
    name     = "block_geo_location_rule_group"
    priority = 3

    override_action {
      none {}
    }
    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.block_geo_location_rule_group.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "self-managed-rule-group"
      sampled_requests_enabled   = true
    }
  }
      rule {
    name     = "allow_geo_location_rule_group"
    priority = 7

    override_action {
      none {}
    }
    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.allow_geo_location_rule_group.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "self-managed-rule-group"
      sampled_requests_enabled   = true
    }
  }
    rule {
    name     = "rate_limit_rule_group"
    priority = 6

    override_action {
      none {}
    }
    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.rate_limit_rule_group.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "self-managed-rule-group"
      sampled_requests_enabled   = true
    }
  }
  tags = merge(
    var.tags,
    {
      Account         = var.account
      Environment     = var.environment
      CreatedBy       = data.aws_caller_identity.current.user_id
      CreatedByArn    = data.aws_caller_identity.current.arn
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
    },
    {
      Name = "${var.account}_${var.environment}_aws_waf"
    }
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"],
    ]
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "web-acl"
    sampled_requests_enabled   = true
  }
}
