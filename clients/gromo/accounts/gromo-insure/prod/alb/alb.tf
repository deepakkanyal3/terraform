#################################################################
# Application Load Balancer
##################################################################

#tfsec:ignore:aws-elb-use-secure-tls-policy
#tfsec:ignore:aws-elb-drop-invalid-headers
module "pvt_alb" {
  source = "../../../../../../modules/alb"

  name                             = "pvt-alb" 
  environment                      = var.environment
  account                          = var.account
  vpc_id                           = var.vpc_id
  # vpc_id = data.aws_vpc.current_vpc.id
  internal                         = true
  security_groups = [module.pvt_alb_sg.sg-id]
  subnets = [
    data.aws_subnet.private_subnet_a.id, data.aws_subnet.private_subnet_b.id, data.aws_subnet.private_subnet_c.id
  ]

  # subnets = [ subnet-08d12f1ede90a11d1, subnet-0cc388cbe051b8130 ]
  
  target_groups = [
    {
      name                              = "fourwheeler-payment-prod"
      protocol                          = "HTTP"
      port                              = 4004
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="4004"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "4004"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "fourwheeler-proposal-prod"
      protocol                          = "HTTP"
      port                              = 4002
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="4002"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "4002"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "fourwheeler-quotation-prod"
      protocol                          = "HTTP"
      port                              = 4001
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="4001"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "4001"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insurance-ag-connect-prod"
      protocol                          = "HTTP"
      port                              = 4000
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="4000"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "4000"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insurance-lead-prod"
      protocol                          = "HTTP"
      port                              = 4006
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="4006"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "4006"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insurance-masterdata-prod"
      protocol                          = "HTTP"
      port                              = 3003
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="3003"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "3003"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-otp-service-prod"
      protocol                          = "HTTP"
      port                              = 4005
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "4005"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "4005"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "insurance-kyc-prod"
      protocol                          = "HTTP"
      port                              = 4003
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "4003"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "4003"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "gromo-rcapi-prod"
      protocol                          = "HTTP"
      port                              = 3005
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3005"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "3005"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "insurance-pos-prod"
      protocol                          = "HTTP"
      port                              = 4015
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "4015"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "4015"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "prod-gromo-hi-care"
      protocol                          = "HTTP"
      port                              = 5003
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5003"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health/care"
        # port                = "5003"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "prod-gromo-hi-facade"
      protocol                          = "HTTP"
      port                              = 3001
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3001"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "3001"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "prod-gromo-hi-hdfc"
      protocol                          = "HTTP"
      port                              = 5005
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5005"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health/hdfc"
        # port                = "5005"
        healthy_threshold   = 3
        unhealthy_threshold = 2
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "prod-gromo-hi-prequote"
      protocol                          = "HTTP"
      port                              = 5000
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5000"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/h-i/health"
        # port                = "5000"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "prod-gromo-hi-reliance"
      protocol                          = "HTTP"
      port                              = 5001
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5001"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health/reliance"
        # port                = "5001"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"


    },
    {
      name                              = "prod-gromo-hi-zuno"
      protocol                          = "HTTP"
      port                              = 5002
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5002"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health/zuno"
        # port                = "5002"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "prod-gromo-hi-niva"
      protocol                          = "HTTP"
      port                              = 5004
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5004"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health/niva"
        # port                = "5004"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "tw-insurance-masterdata-prod"
      protocol                          = "HTTP"
      port                              = 3003
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3003"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "3003"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "prod-twowheeler-motor-insurance"
      protocol                          = "HTTP"
      port                              = 5050
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5050"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        # port                = "3003"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "prod-insure-twowheeler-quotation"
      protocol                          = "HTTP"
      port                              = 5004
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5004"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "3003"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "prod-insure-twowheeler-proposal"
      protocol                          = "HTTP"
      port                              = 5005
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5005"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "3003"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "prod-insure-twowheeler-payment"
      protocol                          = "HTTP"
      port                              = 5006
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5006"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "3003"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "prod-htmltopdfconverter-tg"
      protocol                          = "HTTP"
      port                              = 5000
      target_type                       = "instance"
      # target_id = "i-03a1f5a882d4f21d5"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5000"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "5000"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "404"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "prod-gromo-offline-insurance"
      protocol                          = "HTTP"
      port                              = 3002
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3002"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/api"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
      {
      name                              = "prod-offline-insurance-facade"
      protocol                          = "HTTP"
      port                              = 5008
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5008"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/api"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    }
  ]
  #   # # ## listener rules
  
  http_tcp_listeners = [
      {
      port     = 80
      protocol = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

   https_listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = data.aws_acm_certificate.amazon_issued.arn
      action_type     = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        status_code  = "404"
        message_body = "Error 404"
      }
    },
  ]

  https_listener_rules = [
    {
      https_listener_index = 0
      priority             = 100

      actions = [{
        type               = "forward"
        target_group_index = 0
      }]

      conditions = [{ host_headers = ["mipaymentapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 101

      actions = [{
        type               = "forward"
        target_group_index = 1
      }]

      conditions = [{ host_headers = ["miproposalapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 102

      actions = [{
        type               = "forward"
        target_group_index = 2
      }]

      conditions = [{ host_headers = ["miquotationapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 103

      actions = [{
        type               = "forward"
        target_group_index = 3
      }]

      conditions = [{ host_headers = ["miagconnectapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 104

      actions = [{
        type               = "forward"
        target_group_index = 4
      }]

      conditions = [{ host_headers = ["mileadapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 105

      actions = [{
        type               = "forward"
        target_group_index = 5
      }]

      conditions = [{ host_headers = ["mimasterdataapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 106

      actions = [{
        type               = "forward"
        target_group_index = 6
      }]

      conditions = [{ host_headers = ["otp.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 107

      actions = [{
        type               = "forward"
        target_group_index = 7
      }]

      conditions = [{ host_headers = ["mikycapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 108

      actions = [{
        type               = "forward"
        target_group_index = 8
      }]

      conditions = [{ host_headers = ["mircapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 109

      actions = [{
        type               = "forward"
        target_group_index = 9
      }]

      conditions = [{ host_headers = ["miposapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 110

      actions = [{
        type               = "forward"
        target_group_index = 10
      }]

      conditions = [{ host_headers = ["hicareapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 111

      actions = [{
        type               = "forward"
        target_group_index = 11
      }]

      conditions = [{ host_headers = ["hifrontendapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 112

      actions = [{
        type               = "forward"
        target_group_index = 12
      }]

      conditions = [{ host_headers = ["hihdfcapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 113

      actions = [{
        type               = "forward"
        target_group_index = 13
      }]

      conditions = [{ host_headers = ["hiprequoteapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 114

      actions = [{
        type               = "forward"
        target_group_index = 14
      }]

      conditions = [{ host_headers = ["hirelianceapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 115

      actions = [{
        type               = "forward"
        target_group_index = 15
      }]

      conditions = [{ host_headers = ["hizunoapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 116

      actions = [{
        type               = "forward"
        target_group_index = 16
      }]

      conditions = [{ host_headers = ["hinivaapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 117

      actions = [{
        type               = "forward"
        target_group_index = 17
      }]

      conditions = [{ host_headers = ["twmasterdataapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 118

      actions = [{
        type               = "forward"
        target_group_index = 18
      }]

      conditions = [{ host_headers = ["twapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 119

      actions = [{
        type               = "forward"
        target_group_index = 19
      }]

      conditions = [{ host_headers = ["twquotationapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 120

      actions = [{
        type               = "forward"
        target_group_index = 20
      }]

      conditions = [{ host_headers = ["twproposalapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 121

      actions = [{
        type               = "forward"
        target_group_index = 21
      }]

      conditions = [{ host_headers = ["twpaymentapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 122

      actions = [{
        type               = "forward"
        target_group_index = 22
      }]

      conditions = [{ host_headers = ["htmltopdfconverter-prod.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 123

      actions = [{
        type               = "forward"
        target_group_index = 23
      }]

      conditions = [{ host_headers = ["offlineapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 124

      actions = [{
        type               = "forward"
        target_group_index = 24
      }]

      conditions = [{ host_headers = ["oiflapi.gromoinsure.in"] }]
    }

  ]
    
  # # For example only

  enable_deletion_protection = false
  tags    = local.common_tags
}
################################################################################
# Supporting resources
################################################################################
# data "aws_vpc" "vpc" {
#   id = var.vpc_id
# }

# data "aws_vpcs" "main" {
#   // Your data source configuration to retrieve VPC information
# }

# data "aws_subnet_ids" "public_subnets" {
#   vpc_id = var.vpc_id # Use the appropriate index if you have multiple VPCs
#   // Additional configuration for retrieving public subnets
# }

data "aws_acm_certificate" "amazon_issued" {
  domain      = "*.gromoinsure.in"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

data "aws_acm_certificate" "amazon_issued1" {
  domain      = "*.gromoinsure.com"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}
#********************************************************************************
## Public ALB
#tfsec:ignore:aws-elb-alb-not-public
#tfsec:ignore:aws-elb-drop-invalid-headers
#tfsec:ignore:aws-elb-use-secure-tls-policy
module "pub_alb" {
  source = "../../../../../../modules/alb"

  name                             = "pub-alb" 
  environment                      = var.environment
  account                          = var.account
  vpc_id                           = var.vpc_id
  # vpc_id =   data.aws_vpc.current_vpc.id
  security_groups = [module.pub_alb_sg.sg-id]
  subnets = [
    data.aws_subnet.public_subnet_a.id, data.aws_subnet.public_subnet_b.id
  ]

  # subnets = [ subnet-00fe1fbb523a35d43, subnet-0ec803d0e80507a9b    ]


  enable_deletion_protection = false
  target_groups = [

      
    {
      name                              = "prod-gromo-hi-frontend"
      protocol                          = "HTTP"
      port                              = 3000
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3000"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/ping"
        # port                = "3000" 
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    } ,
     {
      name                              = "gromo-agp-connect-prod"
      protocol                          = "HTTP"
      port                              = 5010
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="5010"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "5010"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insurance-website-prod"
      protocol                          = "HTTP"
      port                              = 5020
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5020"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "5020"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "insurance-nextjs-prod"
      protocol                          = "HTTP"
      port                              = 3010
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3010"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "3010"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "reconciliation-prod"
      protocol                          = "HTTP"
      port                              = 5011
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5011"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "5011"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "prod-gromo-twowheeler-nextjs"
      protocol                          = "HTTP"
      port                              = 7007
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "7007"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "5011"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "prod-pos"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      target_id = "i-0264778edbd9f63da"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "80"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health"
        port                = "80"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "prod-pos-kyc"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      target_id = "i-073aab94543d77fb7"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "80"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/ping"
        port                = "80"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "prod-insurance-lead-crm"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      target_id = "i-03a1f5a882d4f21d5"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "80"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "80"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "404"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "insuranceapi-gromoinsure-in"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      target_id = "i-03a1f5a882d4f21d5"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "80"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "80"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "404"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "prod-insurance-partner"
      protocol                          = "HTTP"
      port                              = 5006
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5006"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/health"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "prod-offline-insurance-fe"
      protocol                          = "HTTP"
      port                              = 5009
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5009"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/ping"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "gromo-insure-prod"
      protocol                          = "HTTP"
      port                              = 4040
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "4040"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "gromo-insure-nextjs-prod"
      protocol                          = "HTTP"
      port                              = 4049
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "4049"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "commercial-insurance-fe-prod"
      protocol                          = "HTTP"
      port                              = 4100
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "4100"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    }
  ]
  # # ## listener rules
  
  http_tcp_listeners = [
      {
      port     = 80
      protocol = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

   https_listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = data.aws_acm_certificate.amazon_issued1.arn
      action_type     = "forward"
      target_group_index = "6"
      # fixed_response = {
      #   content_type = "text/plain"
      #   status_code  = "200"
      #   message_body = "Nothing to see here move along"
      # }
    },
  ]

  https_listener_rules = [
    {
      https_listener_index = 0
      priority             = 100

      actions = [{
        type               = "forward"
        target_group_index = 0
      }]

      conditions = [{ host_headers = ["hi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 101

      actions = [{
        type               = "forward"
        target_group_index = 1
      }]

      conditions = [{ host_headers = ["miagpconnectapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 102

      actions = [{
        type               = "forward"
        target_group_index = 2
      }]

      conditions = [{ host_headers = ["ww1.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 103

      actions = [{
        type               = "forward"
        target_group_index = 3
      }]

      conditions = [{ host_headers = ["mi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 104

      actions = [{
        type               = "forward"
        target_group_index = 4
      }]

      conditions = [{ host_headers = ["recon.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 105

      actions = [{
        type               = "forward"
        target_group_index = 5
      }]

      conditions = [{ host_headers = ["tw.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 106

      actions = [{
        type               = "forward"
        target_group_index = 6
      }]

      conditions = [{ host_headers = ["api.gromoinsure.com"] }]
    },
    {
      https_listener_index = 0
      priority             = 107

      actions = [{
        type               = "forward"
        target_group_index = 7
      }]

      conditions = [{ host_headers = ["kyc.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 108

      actions = [{
        type               = "forward"
        target_group_index = 8
      }]

      conditions = [{ host_headers = ["crm.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 109

      actions = [{
        type               = "forward"
        target_group_index = 9
      }]

      conditions = [{ host_headers = ["insuranceapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 110

      actions = [{
        type               = "forward"
        target_group_index = 10
      }]

      conditions = [{ host_headers = ["partner.gromoinsure.in"] }]
    },
      {
      https_listener_index = 0
      priority             = 111

      actions = [{
        type               = "forward"
        target_group_index = 11
      }]

      conditions = [{ host_headers = ["mioffline.gromoinsure.in"] }]
    },
      {
      https_listener_index = 0
      priority             = 112

      actions = [{
        type               = "forward"
        target_group_index = 12
      }]

      conditions = [{ host_headers = ["pos.gromoinsure.in"] }]
    },
      {
      https_listener_index = 0
      priority             = 113

      actions = [{
        type               = "forward"
        target_group_index = 13
      }]

      conditions = [{ host_headers = ["www.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 114

      actions = [{
        type               = "forward"
        target_group_index = 14
      }]

      conditions = [{ host_headers = ["cv.gromoinsure.in"] }]
    }

  ]

  tags    = local.common_tags
}

