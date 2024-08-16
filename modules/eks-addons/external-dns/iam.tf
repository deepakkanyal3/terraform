data "tls_certificate" "this" {
  count = var.auto_thumbprint_enabled ? 1 : 0

  url = var.url
}

resource "aws_iam_openid_connect_provider" "this" {
  count = var.cross_account ? 1 : 0

  url             = var.url
  client_id_list  = var.audiences
  thumbprint_list = setunion(
    var.thumbprints,
    (var.auto_thumbprint_enabled
      ? data.tls_certificate.this[*].certificates[0].sha1_fingerprint
      : []
    )
  )
  # tags = var.tags
  provider = aws.route53_provider
}



# External DNS IAM Policy 
resource "aws_iam_policy" "externaldns_iam_policy" {
  name        = "${var.eks_cluster}-external-dns-policy" 
  # path        = "/"
  description = "External DNS IAM Policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
              {
            "Effect": "Allow",
            "Action": [
                "route53:ChangeResourceRecordSets",
                "route53domains:*",
                "route53:*"
            ],
            "Resource": "${var.hosted_zone_list}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:ListHostedZones",
                "route53:ListResourceRecordSets",
                "route53:ListTagsForResource"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
  })
  provider = aws.route53_provider
}

# IAM Role 
resource "aws_iam_role" "externaldns_iam_role_cross_account" {
  count = var.cross_account ? 1 : 0
  name = "${var.eks_cluster}-external-dns-role" 

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${aws_iam_openid_connect_provider.this.0.arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${replace(local.oidc_url, "https://", "")}:sub": "system:serviceaccount:${var.namespace}:${var.service_account_name}"
        }
      }
    }
  ]
}
POLICY

  tags = {
    tag-key = "AllowExternalDNSUpdates"
  }
  provider = aws.route53_provider
}

# Associate External DNS IAM Policy to IAM Role
resource "aws_iam_role_policy_attachment" "externaldns_iam_role_policy_attach_cross_account" {
  count = var.cross_account ? 1 : 0
  policy_arn = aws_iam_policy.externaldns_iam_policy.arn
  role       = aws_iam_role.externaldns_iam_role_cross_account.0.name
  provider = aws.route53_provider
}





data "aws_eks_cluster" "cluster" {
   name = var.eks_cluster
 }

 data "aws_caller_identity" "current" {}

 locals {
   oidc_url          = replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")
   oidc_arn_data     = element(split("/", data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer), length(split("/", data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer)) - 1)
   oidc_provider_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.${var.aws_region}.amazonaws.com/id/${local.oidc_arn_data}"
 }



# IAM Role 
resource "aws_iam_role" "externaldns_iam_role_same_account" {
  count = var.cross_account ? 0 : 1
  name = "${var.eks_cluster}-external-dns-role" 

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
{
        Action = "sts:AssumeRoleWithWebIdentity",
        Effect = "Allow",
        # Sid    = "",
        Principal = {
          Federated = "${local.oidc_provider_arn}"
        }
        Condition = {
          StringEquals = {
            "${local.oidc_url}:sub": "system:serviceaccount:${var.namespace}:${var.service_account_name}"
          }
        }
      }
    ]
  })
  tags = {
    tag-key = "AllowExternalDNSUpdates"
  }
  provider = aws.route53_provider
}

# Associate External DNS IAM Policy to IAM Role
resource "aws_iam_role_policy_attachment" "externaldns_iam_role_policy_attach_same_account" {
  count = var.cross_account ? 0 : 1
  policy_arn = aws_iam_policy.externaldns_iam_policy.arn
  role       = aws_iam_role.externaldns_iam_role_same_account.0.name
  provider = aws.route53_provider
}

