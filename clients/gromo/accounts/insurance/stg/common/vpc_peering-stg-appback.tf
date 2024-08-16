data "aws_vpc" "vpc-gromo-stg-appback" {
  id       = "vpc-05668366833b8490a"
  provider = aws.brands-stg
}

module "vpc-peering-account-3" {
  source                 = "../../../../../../modules/vpc_peering"
  environment            = var.environment
  account                = var.account
  tags                   = merge(local.common_tags)
  acceptor_vpc_id        = data.aws_vpc.vpc-gromo-stg-appback.id
  aws_region_acceptor_id = var.AWS_REGION
  providers = {
    aws.requestor = aws
    aws.acceptor  = aws.brands-stg
  }
}