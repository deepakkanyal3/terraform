resource "aws_db_subnet_group" "this" {
  #count = var.create

  name        = var.name
  subnet_ids  = [data.aws_subnet.intra_subnet_a.id, data.aws_subnet.intra_subnet_b.id]

  tags = merge(
    var.tags,
    {
      "Name" = var.name
      CreatedBy = data.aws_caller_identity.current.user_id
      CreatedByArn    = data.aws_caller_identity.current.arn
      account = var.account
      Environment = var.environment
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
    },
  )
}