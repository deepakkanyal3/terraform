# data "aws_vpc" "vpc-gromo-insure-new" {
#   id       = "vpc-0e8a4f5f537d69f71"
#   provider = aws.gromo-insure
# }


# module "vpc-peering-account" {
#   source                 = "../../../../../../modules/vpc_peering"
#   environment            = var.environment
#   account                = var.account
#   tags                   = merge(local.common_tags)
#   acceptor_vpc_id        = data.aws_vpc.vpc-gromo-insure-new.id
#   aws_region_acceptor_id = var.AWS_REGION
#   providers = {
#     aws.requestor = aws
#     aws.acceptor  = aws.gromo-insure
#   }
# }