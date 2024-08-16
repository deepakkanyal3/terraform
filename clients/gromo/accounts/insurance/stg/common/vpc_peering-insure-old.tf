data "aws_vpc" "vpc-gromo-insure" {
  id       = "vpc-04145b34430aecf90"
  provider = aws.insurance-dev
}
# data "aws_vpc" "vpc-gromo-insure_dev" {
#   id       = "vpc-0b8802c1332011ba5"
#   provider = aws.gromo-insure-dev
# }

module "vpc-peering-account-1-account2" {
  source                 = "../../../../../../modules/vpc_peering"
  environment            = var.environment
  account                = var.account
  tags                   = merge(local.common_tags)
  acceptor_vpc_id        = data.aws_vpc.vpc-gromo-insure.id
  aws_region_acceptor_id = var.AWS_REGION

  providers = {
    aws.requestor = aws
    aws.acceptor  = aws.insurance-dev
  }
}

# module "vpc-peering-new-old" {
#   source                 = "../../../../../../modules/vpc_peering"
#   environment            = var.environment
#   account                = var.account
#   tags                   = merge(local.common_tags)
#   acceptor_vpc_id        = data.aws_vpc.vpc-gromo-insure_dev.id
#   aws_region_acceptor_id = var.AWS_REGION

#   providers = {
#     aws.requestor = aws
#     aws.acceptor  = aws.gromo-insure-dev
#   }
# }