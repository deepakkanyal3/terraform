resource "aws_iam_role" "smartcloud_assume_role" {
  name = "smartcloud"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::346173481489:root"  # Replace with the external account ID
        },
        Action = "sts:AssumeRole",
        Condition = {
          StringEquals = {
            "sts:ExternalId" = "smartcloud"  # Replace with your external ID
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "admin_policy" {
  role       = aws_iam_role.smartcloud_assume_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "readonly_policy" {
  role       = aws_iam_role.smartcloud_assume_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}