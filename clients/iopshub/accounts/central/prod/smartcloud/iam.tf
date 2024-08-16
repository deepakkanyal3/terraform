# ******************************************|   Nexus  |**********************************************************
# NexusS3Blob store
# Note: Run this module after creation of EKS Cluster and nexus namespace
# ***********************************************************************************************************************************************

module "iam-api" {
  source         = "../../../../../../modules/iam/sa-iam-role"
  appname        = "${var.appname}-api"
  environment    = var.environment
  account        = var.account
  namespace      = var.namespace
  cluster_name   = "${var.account}-eks-${var.environment}"
  serviceaccount = "${var.serviceaccount}-api"
  AWS_REGION     = var.AWS_REGION
  tags           = local.common_tags
  policy         = {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : "sts:AssumeRole",
        "Resource" :  "*"
        
      }
    ]
  }
}


module "iam-worker" {
  source         = "../../../../../../modules/iam/sa-iam-role"
  appname        = "${var.appname}-worker"
  environment    = var.environment
  account        = var.account
  namespace      = var.namespace
  cluster_name   = "${var.account}-eks-${var.environment}"
  serviceaccount = "${var.serviceaccount}-worker"
  AWS_REGION     = var.AWS_REGION
  tags           = local.common_tags
  policy         = {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : "sts:AssumeRole",
        "Resource" :  "*"
      }
    ]
  }
}