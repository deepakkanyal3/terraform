module "s3-bucket" {
  source      = "../../../../../../modules/s3"
  tags        = local.common_tags
  environment = var.environment
  account     = var.account
  consumer    = "vpc-flow-logs"
  producer    = "vpc-flow-logs"
  bucket      = "vpc-flow-logs"
  
  
#   lifecycle_rule = [
#   {
#     id      = "gromo-appbackend-vpc-flow-logs"
#     enabled = true
#     prefix  = "loki*"

#     tags = {
#       rule      = "log"
#       autoclean = "true"
#     }

#     expiration = {
#       days = 60
#     }

#     noncurrent_version_expiration = {
#       days = 60
#     }
#   }
#   ]
}
