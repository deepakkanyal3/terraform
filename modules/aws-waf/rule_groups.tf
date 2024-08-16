# self managed rule group defination
resource "aws_wafv2_rule_group" "whitelist_rule_group" {
  name        = var.whitelist_rule_group_name
  description = "Self-managed rule group containing various rules"
  scope       = var.scope
  capacity    = var.whitelist_rule_group_capacity

  rule {
    name     = "AllowIPs-office"
    priority = 1

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.office_ip_set.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "allow-ips-rule"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AllowIPs-aws"
    priority = 2

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.aws_ip_set.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "allow-ips-rule"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AllowIPs-vendor"
    priority = 3

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.external_vendor_ip_set.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "allow-ips-rule"
      sampled_requests_enabled   = true
    }
  }
    rule {
    name     = "AllowIPs-data-center"
    priority = 4

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.data_center_ip_set.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "allow-ips-rule"
      sampled_requests_enabled   = true
    }
  }
    rule {
    name     = "AllowIPs-other"
    priority = 5

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.other_whitelisted_ip_set.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "allow-ips-rule"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "self-managed-rule-group"
    sampled_requests_enabled   = true
  }
  depends_on = [aws_wafv2_ip_set.office_ip_set,aws_wafv2_ip_set.aws_ip_set,aws_wafv2_ip_set.external_vendor_ip_set,aws_wafv2_ip_set.data_center_ip_set,aws_wafv2_ip_set.other_whitelisted_ip_set]
}


resource "aws_wafv2_rule_group" "blacklist_rule_group" {
  name        = var.blacklist_rule_group_name
  description = "Self-managed rule group containing various rules"
  scope       = var.scope
  capacity    = var.blacklist_rule_group_capacity
  rule {
    name     = "BlockIPs"
    priority = 0

    action {
      block {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.blacklisted_ip_set.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "block-ips-rule"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "self-managed-rule-group"
    sampled_requests_enabled   = true
  }
  depends_on = [aws_wafv2_ip_set.blacklisted_ip_set]
}

resource "aws_wafv2_rule_group" "block_geo_location_rule_group" {
  name        = "block_geo_location_rule_group"
  description = "Self-managed rule group containing various rules"
  scope       = var.scope
  capacity    = var.block_geo_location_rule_group_capacity

  rule {
    name     = "block_geo_location"
    priority = 10

    action {
      block {}
    }

    statement {
      geo_match_statement {
        country_codes = var.block_geo_location
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "block-us-rule"
      sampled_requests_enabled   = true
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "self-managed-rule-group"
    sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_rule_group" "allow_geo_location_rule_group" {
  name        = "allow_geo_location_rule_group"
  description = "Self-managed rule group containing various rules"
  scope       = var.scope
  capacity    = var.allow_geo_location_rule_group_capacity

    rule {
    name     = "block_other_geo_location"
    priority = 13

    action {
      block {}
    }

    statement {
      not_statement {
        statement {
          geo_match_statement {
            country_codes = var.allow_geo_location
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "block-other-geo-location-rule"
      sampled_requests_enabled   = true
    }
  }
    visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "self-managed-rule-group"
    sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_rule_group" "rate_limit_rule_group" {
  name        = "rate_limit_rule_group"
  description = "Self-managed rule group for rate limiting"
  scope       = var.scope
  capacity    = 50

  rule {
    name     = "rate_limit_rule"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = var.rate_limit
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "rate-limit-rule"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "rate-limit-rule-group"
    sampled_requests_enabled   = true
  }
}