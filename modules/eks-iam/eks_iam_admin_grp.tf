resource "aws_iam_group" "eksadmins_iam_group" {
  name = "${var.account}-${var.environment}-eksadmins"
  path = "/"
}

# Resource: AWS IAM Group Policy
resource "aws_iam_group_policy" "eksadmins_iam_group_assumerole_policy" {
  name  = "${var.account}-${var.environment}-eksadmins-group-policy"
  group = aws_iam_group.eksadmins_iam_group.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Sid      = "AllowAssumeOrganizationAccountRole"
        Resource = aws_iam_role.eks_admin_role.arn
      },
    ]
  })
}
# For Testing eksadmin role and group
# Resource: AWS IAM User - Basic User 
resource "aws_iam_user" "eksadmin_user" {
  name          = "${var.account}-${var.name}-${var.environment}-admin"
  path          = "/"
  force_destroy = true
  tags          = merge(
    var.tags,
    {
      Account         = var.account
      Environment     = var.environment
      CreatedBy       = data.aws_caller_identity.current.user_id
      CreatedByArn    = data.aws_caller_identity.current.arn
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
    },
    {
      Name = "${var.account}-${var.name}-${var.environment}-admin"
    }
  )
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"],
    ]
  }
}

# Resource: AWS IAM Group Membership
resource "aws_iam_group_membership" "eksadmins" {
  name  = "${var.account}-${var.name}-${var.environment}-admins-group-membership"
  users = [
    aws_iam_user.eksadmin_user.name
  ]
  group = aws_iam_group.eksadmins_iam_group.name
}