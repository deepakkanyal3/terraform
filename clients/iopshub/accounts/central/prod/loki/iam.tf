# ******************************************|   Nexus  |**********************************************************
# NexusS3Blob store
# Note: Run this module after creation of EKS Cluster and nexus namespace
# ***********************************************************************************************************************************************

module "iam" {
  depends_on     = [module.s3-bucket]
  source         = "../../../../../../modules/iam/sa-iam-role"
  appname        = var.appname
  environment    = var.environment
  account        = var.account
  namespace      = var.namespace
  cluster_name   = "${var.account}-eks-${var.environment}"
  serviceaccount = var.serviceaccount
  AWS_REGION     = var.AWS_REGION
  tags           = local.common_tags
  policy         = {
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
          module.s3-bucket.s3_bucket_arn
        ]
      }
    ]
  }
}