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
  
  target_groups = [
    {
      name                              = "gromo-insurance-lead-stg"
      protocol                          = "HTTP"
      port                              = 4006
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="4006"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "insurance-kyc-stg"
      protocol                          = "HTTP"
      port                              = 4003
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="4003"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "insurance-pos-stg"
      protocol                          = "HTTP"
      port                              = 4015
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="4015"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-rcapi-stg"
      protocol                          = "HTTP"
      port                              = 3005
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="3005"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        # port                = "4000"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insurance-masterdata-stg"
      protocol                          = "HTTP"
      port                              = 3003
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="3003"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-otp-service-stg"
      protocol                          = "HTTP"
      port                              = 4005
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="4005"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "stg-insure-twowheeler-payment"
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
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "stg-insure-twowheeler-proposal"
      protocol                          = "HTTP"
      port                              = 5005
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5005"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "stg-insure-twowheeler-quotation"
      protocol                          = "HTTP"
      port                              = 5004
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5004"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "stg-htmltopdfconverter-tg"
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
        path                = "/"
        healthy_threshold   = 5
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insurance-ag-connect-stg"
      protocol                          = "HTTP"
      port                              = 4000
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "4000"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        healthy_threshold   = 5
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "stg-gromo-hi-zuno"
      protocol                          = "HTTP"
      port                              = 5002
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5002"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/health/zuno"
        healthy_threshold   = 3
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "stg-gromo-hi-hdfc"
      protocol                          = "HTTP"
      port                              = 5005
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5005"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/health/hdfc"
        # port                = "5005"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "stg-gromo-hi-care"
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
        healthy_threshold   = 5
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "stg-gromo-hi-reliance"
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
        healthy_threshold   = 5
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"


    },
    {
      name                              = "stg-gromo-hi-niva"
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
        healthy_threshold   = 3
        unhealthy_threshold = 2
        timeout             = 3
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "stg-gromo-hi-prequote"
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
        # port                = "5004"
        healthy_threshold   = 5
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "stg-gromo-hi-facade"
      protocol                          = "HTTP"
      port                              = 3001
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3001"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "stg-gromo-offline-insurance"
      protocol                          = "HTTP"
      port                              = 3002
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3002"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/api"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "stg-offline-insurance-facade"
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
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "gromo-fourwheeler-quotation-stg"
      protocol                          = "HTTP"
      port                              = 4001
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "4001"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-fourwheeler-proposal-stg"
      protocol                          = "HTTP"
      port                              = 4002
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "4002"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-fourwheeler-payment-stg"
      protocol                          = "HTTP"
      port                              = 4004
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "4004"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insurance-crm-service-stg"
      protocol                          = "HTTP"
      port                              = 3001
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3001"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
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

      conditions = [{ host_headers = ["mileadstagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 101

      actions = [{
        type               = "forward"
        target_group_index = 1
      }]

      conditions = [{ host_headers = ["mikycstagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 102

      actions = [{
        type               = "forward"
        target_group_index = 2
      }]

      conditions = [{ host_headers = ["posstagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 103

      actions = [{
        type               = "forward"
        target_group_index = 3
      }]

      conditions = [{ host_headers = ["mircstagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 104

      actions = [{
        type               = "forward"
        target_group_index = 4
      }]

      conditions = [{ host_headers = ["mimasterstagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 105

      actions = [{
        type               = "forward"
        target_group_index = 5
      }]

      conditions = [{ host_headers = ["otpstaging.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 106

      actions = [{
        type               = "forward"
        target_group_index = 6
      }]

      conditions = [{ host_headers = ["twpaymentstagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 107

      actions = [{
        type               = "forward"
        target_group_index = 7
      }]

      conditions = [{ host_headers = ["twproposalstagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 108

      actions = [{
        type               = "forward"
        target_group_index = 8
      }]

      conditions = [{ host_headers = ["twquotationstagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 109

      actions = [{
        type               = "forward"
        target_group_index = 9
      }]

      conditions = [{ host_headers = ["htmltopdfconverter-stg.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 110

      actions = [{
        type               = "forward"
        target_group_index = 10
      }]

      conditions = [{ host_headers = ["agconnectstagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 111

      actions = [{
        type               = "forward"
        target_group_index = 11
      }]

      conditions = [{ host_headers = ["hizunostagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 112

      actions = [{
        type               = "forward"
        target_group_index = 12
      }]

      conditions = [{ host_headers = ["hihdfcstagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 113

      actions = [{
        type               = "forward"
        target_group_index = 13
      }]

      conditions = [{ host_headers = ["hicarestagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 114

      actions = [{
        type               = "forward"
        target_group_index = 14
      }]

      conditions = [{ host_headers = ["hireliancestagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 115

      actions = [{
        type               = "forward"
        target_group_index = 15
      }]

      conditions = [{ host_headers = ["hinivastagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 116

      actions = [{
        type               = "forward"
        target_group_index = 16
      }]

      conditions = [{ host_headers = ["hiprequotestagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 117

      actions = [{
        type               = "forward"
        target_group_index = 17
      }]

      conditions = [{ host_headers = ["hifrontendstagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 118

      actions = [{
        type               = "forward"
        target_group_index = 18
      }]

      conditions = [{ host_headers = ["offlinestagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 119

      actions = [{
        type               = "forward"
        target_group_index = 19
      }]

      conditions = [{ host_headers = ["oiflstagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 120

      actions = [{
        type               = "forward"
        target_group_index = 20
      }]

      conditions = [{ host_headers = ["fw-quotation-api-stg.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 121

      actions = [{
        type               = "forward"
        target_group_index = 21
      }]

      conditions = [{ host_headers = ["fw-proposal-api-stg.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 122

      actions = [{
        type               = "forward"
        target_group_index = 22
      }]

      conditions = [{ host_headers = ["fw-payment-api-stg.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 123

      actions = [{
        type               = "forward"
        target_group_index = 23
      }]

      conditions = [{ host_headers = ["crm-stg.gromoinsure.in"] }]
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

# data "aws_acm_certificate" "amazon_issued1" {
#   domain      = "*.gromoinsure.com"
#   types       = ["AMAZON_ISSUED"]
#   most_recent = true
# }
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


  enable_deletion_protection = false
  target_groups = [

      
    {
      name                              = "stg-gromo-twowheeler-nextjs"
      protocol                          = "HTTP"
      port                              = 7007
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "7007"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/ping"
        # port                = "3000" 
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    } ,
     {
      name                              = "gromoinsure-insurance-stg"
      protocol                          = "HTTP"
      port                              = 5501
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="5501"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/health"
        # port                = "5010"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-agp-connect-stg"
      protocol                          = "HTTP"
      port                              = 5010
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5010"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        # port                = "5020"
        healthy_threshold   = 5
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "stg-gromo-hi-frontend"
      protocol                          = "HTTP"
      port                              = 3000
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3000"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/ping"
        # port                = "3010"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "stg-twowheeler-motor-insurance"
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
        path                = "/health"
        # port                = "80"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "stg-offline-insurance-fe"
      protocol                          = "HTTP"
      port                              = 5009
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5009"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/ping"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "stg-insurance-partner"
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
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insure-pos-stg"
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
        path                = "/health"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insure-broking-backend-stg"
      protocol                          = "HTTP"
      port                              = 3000
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3000"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/health"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insure-kyc-service-stg"
      protocol                          = "HTTP"
      port                              = 3009
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3009"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/health"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insure-motor-nextjs-stg"
      protocol                          = "HTTP"
      port                              = 3010
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3010"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insurance-website-stg"
      protocol                          = "HTTP"
      port                              = 5020
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5020"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insure-nextjs-stg"
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
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "commercial-insurance-fe-stg"
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
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-fourwheeler-insurance-stg"
      protocol                          = "HTTP"
      port                              = 3006
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3006"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/health"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
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
      certificate_arn = data.aws_acm_certificate.amazon_issued.arn
      action_type     = "forward"
      # action_type = "fixed-response"
      target_group_index = "8"
      fixed_response = {
        content_type = "text/plain"
        status_code  = "404"
        message_body = "NOT FOUND"
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

      conditions = [{ host_headers = ["twstaging.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 101

      actions = [{
        type               = "forward"
        target_group_index = 1
      }]

      conditions = [{ host_headers = ["insuranceapi-stg.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 102

      actions = [{
        type               = "forward"
        target_group_index = 2
      }]

      conditions = [{ host_headers = ["agpconnectstagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 103

      actions = [{
        type               = "forward"
        target_group_index = 3
      }]

      conditions = [{ host_headers = ["histaging.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 104

      actions = [{
        type               = "forward"
        target_group_index = 4
      }]

      conditions = [{ host_headers = ["twstagingapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 105

      actions = [{
        type               = "forward"
        target_group_index = 5
      }]

      conditions = [{ host_headers = ["miofflinestaging.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 106

      actions = [{
        type               = "forward"
        target_group_index = 6
      }]

      conditions = [{ host_headers = ["partnerstaging.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 107

      actions = [{
        type               = "forward"
        target_group_index = 7
      }]

      conditions = [{ host_headers = ["pos-stg.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 108

      actions = [{
        type               = "forward"
        target_group_index = 8
      }]

      conditions = [{ host_headers = ["api-stg.gromoinsure.com"] }]
    },
    {
      https_listener_index = 0
      priority             = 109

      actions = [{
        type               = "forward"
        target_group_index = 9
      }]

      conditions = [{ host_headers = ["stagingkyc.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 110

      actions = [{
        type               = "forward"
        target_group_index = 10
      }]

      conditions = [{ host_headers = ["motor-stg.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 111

      actions = [{
        type               = "forward"
        target_group_index = 11
      }]

      conditions = [{ host_headers = ["www.stg.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 112

      actions = [{
        type               = "forward"
        target_group_index = 12
      }]

      conditions = [{ host_headers = ["stg.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 113

      actions = [{
        type               = "forward"
        target_group_index = 13
      }]

      conditions = [{ host_headers = ["cv-stg.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 114

      actions = [{
        type               = "forward"
        target_group_index = 14
      }]

      conditions = [{ host_headers = ["mv-stg.gromoinsure.in"] }]
    }
  ] 
 
  tags    = local.common_tags
}