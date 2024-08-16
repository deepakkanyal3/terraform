data "aws_vpc" "vpc-gromo-prod-appback" {
  id       = "vpc-011cf109f412ddf07"
  provider = aws.brands-prod
}

module "vpc-peering-account-2" {
  source                 = "../../../../../../modules/vpc_peering"
  environment            = var.environment
  account                = var.account
  tags                   = merge(local.common_tags)
  acceptor_vpc_id        = data.aws_vpc.vpc-gromo-prod-appback.id
  aws_region_acceptor_id = var.AWS_REGION
  providers = {
    aws.requestor = aws
    aws.acceptor  = aws.brands-prod
  }
}