resource "aws_directory_service_directory" "bar" {
  name     = var.domain_name
  password = var.password
  edition  = var.edition
  type     = var.type
  vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = var.subnet_ids
  }
tags = merge(
    #These are user defined tags
    var.tags,

    #These are mandotary tags
    {
      Account         = var.account
      Environment     = var.environment
      CreatedBy       = data.aws_caller_identity.current.user_id
      CreatedByArn    = data.aws_caller_identity.current.arn
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
    }
  )
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"],
    ]
  }
}