resource "aws_iam_role" "ec2_role" {
  name               = "${var.account}-${var.environment}-logs-target-ec2-role"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}
#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "ec2_policy" {
  name        = "${var.account}-${var.environment}-logs-target-ec2-policy"
  description = "${var.account}-${var.environment}-logs-target account policy"
  depends_on  = [
    aws_iam_role.ec2_role
  ]

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "VisualEditor0",
        Effect = "Allow",
        Action = [
          "s3:*",
          "ec2:DescribeInstances",
          "elasticloadbalancing:RegisterTargets",
          "elasticloadbalancing:DeregisterTargets",
          "elasticloadbalancing:DescribeTargetHealth",
          "elasticloadbalancing:DescribeTargetGroups",
        ],
        Resource = "*",
      },
      {
        Sid    = "VisualEditor1",
        Effect = "Allow",
        Action = ["s3:*"],
        Resource = ["arn:aws:s3:::gromo-insure-log-archieve-prod"],
      },
      {
        Sid    = "VisualEditor2",
        Effect = "Allow",
        Action = ["s3:*", "s3:PutObject", "s3:GetObject", "s3:ListBucket"],
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "policy_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
  depends_on = [
    aws_iam_role.ec2_role
  ]
}

resource "aws_iam_instance_profile" "ec2_profile" {
  role       = aws_iam_role.ec2_role.name
  name       = "ec2_profile"
  depends_on = [
    aws_iam_role.ec2_role
  ]
}


