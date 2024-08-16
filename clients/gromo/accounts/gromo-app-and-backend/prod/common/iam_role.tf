resource "aws_iam_role" "vpc_flowlogs_role" {
  name               = "${var.account}-${var.environment}-flow-logs-target"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "vpc-flow-logs.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "s3_bucket_policy" {
  name        = "${var.account}-${var.environment}-flow-logs-target-"
  description = "${var.account}-${var.environment}-flow-logs-target account policy"
  depends_on  = [
    aws_iam_role.vpc_flowlogs_role
  ]

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:ListObject",
          "s3:DeleteObject"
        ],
        "Resource" : [
          "${module.s3-bucket.s3_bucket_arn}/*",
          "${module.s3-bucket.s3_bucket_arn}"
        ]
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "policy_attach" {
  role       = aws_iam_role.vpc_flowlogs_role.name
  policy_arn = aws_iam_policy.s3_bucket_policy.arn
  depends_on = [
    aws_iam_role.vpc_flowlogs_role
  ]
}