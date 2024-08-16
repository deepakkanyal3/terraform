data "aws_vpc" "vpc-gromo-insure-prod" {
  id       = "vpc-02f223f637a1188a1"
  provider = aws.insurance-prod
}

module "vpc-peering-insure-stg-prod" {
  source                 = "../../../../../../modules/vpc_peering"
  environment            = var.environment
  account                = var.account
  tags                   = merge(local.common_tags)
  acceptor_vpc_id        = data.aws_vpc.vpc-gromo-insure-prod.id
  aws_region_acceptor_id = var.AWS_REGION
  providers = {
    aws.requestor = aws
    aws.acceptor  = aws.insurance-prod
  }
}