data "aws_caller_identity" "source" {
  provider = aws.vpc_provider
}

data "aws_iam_policy_document" "assume_role" {
  provider = aws.second_provider
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.source.account_id}:root"]
    }
  }
}

data "aws_iam_policy" "switch" {
  provider = aws.second_provider
  name     = "AdministratorAccess"
}

resource "aws_iam_role" "assume_role" {
  provider            = aws.second_provider
  name                = "SwitchRole-${var.account}_${var.environment}"
  assume_role_policy  = data.aws_iam_policy_document.assume_role.json
  managed_policy_arns = [data.aws_iam_policy.switch.arn]

    tags = merge(
    var.tags,
    {
      Account         = var.account
      Environment     = var.environment
      CreatedBy       = data.aws_caller_identity.source.user_id
      CreatedByArn    = data.aws_caller_identity.source.arn
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
    },
    {
      Name = "${var.account}_${var.environment}_switchrole"
    }
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"],
    ]
  }
}