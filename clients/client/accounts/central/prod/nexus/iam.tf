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
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetLifecycleConfiguration",
          "s3:PutLifecycleConfiguration",
          "s3:PutObjectTagging",
          "s3:GetObjectTagging",
          "s3:DeleteObjectTagging",
          "s3:GetBucketAcl",
          "s3:CreateBucket"
        ],
        "Resource" : [
          "${module.s3-bucket.s3_bucket_arn}/*",
          module.s3-bucket.s3_bucket_arn
        ]
        "Effect" : "Allow"

      }
    ]
  }

}