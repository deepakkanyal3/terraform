#################################################################
# Application Load Balancer
##################################################################
#tfsec:ignore:aws-elb-use-secure-tls-policy
module "nlb-01" {
  source = "../../../../../../modules/alb"

  name                             = "nlb" 
  environment                      = var.environment
  account                          = var.account
  vpc_id                           = var.vpc_id
   internal                        = true
  load_balancer_type               = "network"
#   subnets = data .aws_vpc.public_subnets
  # security_groups = [module.nlb_sg.sg-id]
  subnets = [
    data.aws_subnet.private_subnet_a.id, data.aws_subnet.private_subnet_b.id
  ]
  enable_deletion_protection = false
  tags    = local.common_tags
  target_groups = [
    {
      name                              = "insurance-nlb-stg"
      protocol                          = "TCP"
      port                              = "80"
      target_type                       = "instance"
      target_id                         = "i-066b8f287c5ea7054"
      deregistration_delay              = 30
      load_balancing_cross_zone_enabled = true
      backend_port="80"
      backend_protocol = "TCP"
      health_check = {
        enabled             = true
        interval            = 10
        port                = "traffic-port"
        healthy_threshold   = 5
        unhealthy_threshold = 2
        timeout             = 10
        protocol            = "TCP"
      }
    }
  ]


  https_listeners = [
    {
      port     = 443
      protocol = "TLS"
      certificate_arn = data.aws_acm_certificate.amazon_issued.arn
    }
  ]
}
################################################################################
# Supporting resources
################################################################################
data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_vpcs" "main" {
  // Your data source configuration to retrieve VPC information
}


data "aws_acm_certificate" "amazon_issued" {
  domain      = "*.gromoinsure.in"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

# data "aws_subnet_ids" "public_subnets" {
#   vpc_id = var.vpc_id # Use the appropriate index if you have multiple VPCs
#   // Additional configuration for retrieving public subnets
# }