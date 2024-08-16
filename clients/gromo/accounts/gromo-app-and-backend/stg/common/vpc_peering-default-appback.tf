data "aws_vpc" "vpc-gromo-app-backend" {
  id       = "vpc-84e4d2ec"
  provider = aws.brands-prod
}

module "vpc-peering-account-1" {
  source                 = "../../../../../../modules/vpc_peering"
  environment            = var.environment
  account                = var.account
  tags                   = merge(local.common_tags)
  acceptor_vpc_id        = data.aws_vpc.vpc-gromo-app-backend.id
  aws_region_acceptor_id = var.AWS_REGION
  providers = {
    aws.requestor = aws
    aws.acceptor  = aws.brands-prod
  }
}