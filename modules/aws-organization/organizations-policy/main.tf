locals {
  static_policy_content = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect   = "Deny",
        Action   = "*",
        Resource = "*",
        Condition = {
          StringNotEquals = {
            "aws:RequestedRegion" = ["ap-south-1"]  
          }
        }
      }
    ]
  })
  encryption_policy_content = jsonencode({
    Version   = "2012-10-17",
    Statement = [
        {
            Effect = "Deny",
            Action = [
                "ec2:CreateVolume"
            ],
            Condition = {
                Bool = {
                    "ec2:Encrypted": "false"
                }
            },
            Resource = [
                "*"
            ]
        }
    ]
  })
  ec2_type = jsonencode({
    Version   = "2012-10-17",
    Statement = [
    {
      "Sid": "DenyNonT3aInstanceTypes",
      "Effect": "Deny",
      "Action": "ec2:RunInstances",
      "Resource": "arn:aws:ec2:*:*:instance/*",
      "Condition": {
        "StringNotLike": {
          "ec2:InstanceType": "t3a.*"
        }
      }
    }
  ]
  })
}


# Policy create
# resource "aws_organizations_policy" "this" {
#   content      = var.content
#   name         = var.name
#   description  = var.description
#   skip_destroy = var.skip_destroy
#   type         = var.type
#   tags         = var.tags
# }

# Region restriction policy
resource "aws_organizations_policy" "region" {
  count        = var.region_restriction ? 1 : 0

  content      = local.static_policy_content
  name         = "region_restriction"
  description  = "Region Restriction"
  skip_destroy = var.skip_destroy
  type         = var.type
  tags         = var.tags
}

# New volumes created shoulb be encrypted
resource "aws_organizations_policy" "encryption" {
  count        = var.volume_encryption ? 1 : 0

  content      = local.encryption_policy_content
  name         = "gromo_ebs_encryption"
  description  = "volume restriction policy"
  skip_destroy = var.skip_destroy
  type         = var.type
  tags         = var.tags
}

# Ec2 launched only allowed for t3a series
resource "aws_organizations_policy" "ec2" {
  count        = var.ec2_launch ? 1 : 0

  content      = local.ec2_type
  name         = "t3a-ec2-allowed"
  description  = "This scp only allowes t3a searies"
  skip_destroy = var.skip_destroy
  type         = var.type
  tags         = var.tags
}


resource "aws_organizations_policy" "custom_policy" {

  content      = var.content
  name         = var.name
  description  = var.description
  skip_destroy = var.skip_destroy
  type         = var.type
  tags         = var.tags
}
