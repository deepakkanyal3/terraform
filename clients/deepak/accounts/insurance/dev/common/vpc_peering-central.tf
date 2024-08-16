# data "aws_vpc" "vpc-gromo-central" {
#   id       = "vpc-0e8304594b0a5d981"
#   provider = aws.gromo-central
# }

# module "vpc-peering-account-1-account3" {
#   source                 = "../../../../../../modules/vpc_peering"
#   environment            = var.environment
#   account                = var.account
#   tags                   = merge(local.common_tags)
#   acceptor_vpc_id        = data.aws_vpc.vpc-gromo-central.id
#   aws_region_acceptor_id = var.AWS_REGION
#   providers = {
#     aws.requestor = aws
#     aws.acceptor  = aws.gromo-central
#   }
# }