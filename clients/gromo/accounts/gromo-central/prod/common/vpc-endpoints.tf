locals {
  ingress_rules = [
    {
      from_port = 443,
      to_port = 443,
      protocol = "tcp",
      cidr_block = var.vpc_cidr,
      description = "For internal service communication"
    }
  ]

  # gateway_endpoint_list = [
  #   {
  #     name = "s3"
  #     endpoint = "com.amazonaws.us-east-1.s3" 
  #   }
  #]
  interface_endpoint_list = [
    {
      name = "apigateway"
      endpoint = "com.amazonaws.ap-south-1.execute-api" 
    },
  ]
}

module "vpc_endpoint" {
  source              = "../../../../../../modules/vpc-endpoint"
  environment            = var.environment
  account                = var.account
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.private_subnets
  route_table_ids = module.vpc.private_route_table_ids
  ingress_rules = local.ingress_rules
  # gateway_endpoint_list = local.gateway_endpoint_list
  # interface_endpoint_list = local.interface_endpoint_list
}
