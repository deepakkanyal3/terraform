data "aws_vpc" "vpc-gromo-insure" {
  id       = "vpc-04145b34430aecf90"
  provider = aws.gromo-insure
}

module "vpc-peering" {
  source                 = "../../../../../../modules/vpc_peering"
  environment            = var.environment
  account                = var.account
  tags                   = merge(local.common_tags)
  acceptor_vpc_id        = data.aws_vpc.vpc-gromo-insure.id
  aws_region_acceptor_id = var.AWS_REGION
  providers = {
    aws.requestor = aws
    aws.acceptor  = aws.gromo-insure
  }
}