locals {
  azs      = var.azs
  vpc_cidr = var.vpc_cidr

}

#tfsec:ignore:aws-ec2-no-public-ingress-acl
#tfsec:ignore:aws-ec2-no-excessive-port-access
#tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
module "vpc" {
  source = "../../../../../../modules/vpc"
  

  account     = var.account
  environment = var.environment
  tags = merge(
    local.common_tags,

  )
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"                             = 1
    "kubernetes.io/cluster/${var.account}-eks-${var.environment}" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/role/elb"                                      = 1
    "kubernetes.io/cluster/${var.account}-eks-${var.environment}" = "shared"
  }
  name = "vpc"
  cidr = local.vpc_cidr

# Firewall subnets and NACL
  firewall_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 6, k + 50)]
  firewall_dedicated_network_acl   = true

  firewall_inbound_acl_rules  = concat(local.network_acls["default_inbound"], local.network_acls["firewall_inbound"])
  firewall_outbound_acl_rules = concat(local.network_acls["default_outbound"], local.network_acls["firewall_outbound"])


 ################################################################################
  # NETWORK FIREWALL
 ################################################################################

# Enable this if you want to make route table changes for firewall
  # enable_network_firewall = true

# Firewall endpoints that need to be mapped in the respectative route tables (Note - It shoub be enabled after firewall creation)
  # firewall_endpoint_a = module.firewall.endpoints[0][0][0]
  # firewall_endpoint_b = module.firewall.endpoints[0][1][0]
  # firewall_endpoint_c = module.firewall.endpoints[0][2][0]





  azs                = local.azs
  public_subnets     = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 1)]
  private_subnets    = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 5, k + 2)]
  intra_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 6, k + 25)]
  enable_nat_gateway = true

  create_backend_subnet_group   = true
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  public_dedicated_network_acl  = true
  private_dedicated_network_acl = true
  intra_dedicated_network_acl   = true

  public_inbound_acl_rules  = concat(local.network_acls["default_inbound"], local.network_acls["public_inbound"])
  public_outbound_acl_rules = concat(local.network_acls["default_outbound"], local.network_acls["public_outbound"])

  private_inbound_acl_rules  = concat(local.network_acls["default_inbound"], local.network_acls["private_inbound"])
  private_outbound_acl_rules = concat(local.network_acls["default_outbound"], local.network_acls["private_outbound"])

  intra_inbound_acl_rules  = concat(local.network_acls["default_outbound"], local.network_acls["intra_outbound"])
  intra_outbound_acl_rules = concat(local.network_acls["default_outbound"], local.network_acls["intra_outbound"])

  single_nat_gateway     = true
  reuse_nat_ips          = false
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_dhcp_options = true
  # dhcp_options_domain_name         = "domain.in"
  # dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]

  enable_flow_log                      = false
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60
  flow_log_cloudwatch_log_group_retention_in_days = 30


  # flow_log_destination_type  = "s3"
  # flow_log_destination_arn = "arn:aws:s3:::gromo-app-and-backend-vpc-flow-logs-prod"
  # flow_log_file_format =  ""
  # flow_log_cloudwatch_iam_role_arn = aws_iam_role.vpc_flowlogs_role.arn
}

resource "aws_default_route_table" "default" {
  default_route_table_id = module.vpc.default_route_table_id

  tags = {
    Name = "Do Not Use It"
  }
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = module.vpc.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "deny"
    cidr_block = var.vpc_cidr
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "deny"
    cidr_block = var.vpc_cidr
    from_port  = 0
    to_port    = 0
  }
  tags = {
    Name = "Do Not Use It"
  }
}
