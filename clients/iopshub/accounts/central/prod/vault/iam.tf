

module "iam" {
  #depends_on     = [module.s3-bucket]
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
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:DescribeKey"
            ],
            "Resource": "arn:aws:kms:ap-south-1:346173481489:key/e0dc7ee1-bcdd-4e06-a3c1-2cad6db7851c"
        }
    ]
}
}