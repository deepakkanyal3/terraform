data "aws_vpc" "vpc-gromo-insure-dev" {
  id       = "vpc-07b3bda62a9c92fe2"
  provider = aws.insurance-prod
}


module "vpc-peering-account-dev" {
  source                 = "../../../../../../modules/vpc_peering"
  environment            = var.environment
  account                = var.account
  tags                   = merge(local.common_tags)
  acceptor_vpc_id        = data.aws_vpc.vpc-gromo-insure-dev.id
  aws_region_acceptor_id = var.AWS_REGION
  providers = {
    aws.requestor = aws
    aws.acceptor  = aws.insurance-prod
  }
}