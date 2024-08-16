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
      name                              = "gromo-insurance-ag-connect-dev"
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
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "gromo-hi-care-dev"
      protocol                          = "HTTP"
      port                              = 5003
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="5003"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health/care"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-hi-hdfc-dev"
      protocol                          = "HTTP"
      port                              = 5005
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="5005"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health/hdfc"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-hi-niva-dev"
      protocol                          = "HTTP"
      port                              = 5004
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="5004"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health/niva"
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
      name                              = "gromo-hi-prequote-dev"
      protocol                          = "HTTP"
      port                              = 5000
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="5000"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/h-i/health"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-hi-reliance-dev"
      protocol                          = "HTTP"
      port                              = 5001
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="5001"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health/reliance"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-hi-zuno-dev"
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
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-agp-connect-dev"
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
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"
    },
    {
      name                              = "gromo-fourwheeler-quotation-dev"
      protocol                          = "HTTP"
      port                              = 4001
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "4001"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
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
      name                              = "gromo-rcapi-dev"
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
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-fourwheeler-proposal-dev"
      protocol                          = "HTTP"
      port                              = 4002
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "4002"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
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
      name                              = "gromo-fourwheeler-payment-dev"
      protocol                          = "HTTP"
      port                              = 4004
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "4004"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
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
      name                              = "gromo-otp-service-dev"
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
        # port                = "5005"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insure-tw-quotation-dev"
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
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insure-tw-proposal-dev"
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
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"


    },
    {
      name                              = "gromo-insurance-kyc-dev"
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
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-insure-tw-payment-dev"
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
      name                              = "gromo-insurance-masterdata-dev"
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
      name                              = "gromo-insurance-lead-dev"
      protocol                          = "HTTP"
      port                              = 4006
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "4006"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
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
      name                              = "gromo-insurance-pos-dev"
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
        # port                = "5004"
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

      conditions = [{ host_headers = ["agconnectdevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 101

      actions = [{
        type               = "forward"
        target_group_index = 1
      }]

      conditions = [{ host_headers = ["hicaredevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 102

      actions = [{
        type               = "forward"
        target_group_index = 2
      }]

      conditions = [{ host_headers = ["hihdfcdevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 103

      actions = [{
        type               = "forward"
        target_group_index = 3
      }]

      conditions = [{ host_headers = ["hinivadevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 104

      actions = [{
        type               = "forward"
        target_group_index = 4
      }]

      conditions = [{ host_headers = ["hiprequotedevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 105

      actions = [{
        type               = "forward"
        target_group_index = 5
      }]

      conditions = [{ host_headers = ["hireliancedevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 106

      actions = [{
        type               = "forward"
        target_group_index = 6
      }]

      conditions = [{ host_headers = ["hizunodevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 107

      actions = [{
        type               = "forward"
        target_group_index = 7
      }]

      conditions = [{ host_headers = ["agpconnectdevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 108

      actions = [{
        type               = "forward"
        target_group_index = 8
      }]

      conditions = [{ host_headers = ["fw-quotation-api-dev.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 109

      actions = [{
        type               = "forward"
        target_group_index = 9
      }]

      conditions = [{ host_headers = ["mircdevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 110

      actions = [{
        type               = "forward"
        target_group_index = 10
      }]

      conditions = [{ host_headers = ["fw-proposal-api-dev.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 111

      actions = [{
        type               = "forward"
        target_group_index = 11
      }]

      conditions = [{ host_headers = ["fw-payment-api-dev.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 112

      actions = [{
        type               = "forward"
        target_group_index = 12
      }]

      conditions = [{ host_headers = ["otpdev.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 113

      actions = [{
        type               = "forward"
        target_group_index = 13
      }]

      conditions = [{ host_headers = ["twquotationdevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 114

      actions = [{
        type               = "forward"
        target_group_index = 14
      }]

      conditions = [{ host_headers = ["twproposaldevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 115

      actions = [{
        type               = "forward"
        target_group_index = 15
      }]

      conditions = [{ host_headers = ["mikycdevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 116

      actions = [{
        type               = "forward"
        target_group_index = 16
      }]

      conditions = [{ host_headers = ["twpaymentdevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 117

      actions = [{
        type               = "forward"
        target_group_index = 17
      }]

      conditions = [{ host_headers = ["mv-masterdata-dev.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 118

      actions = [{
        type               = "forward"
        target_group_index = 18
      }]

      conditions = [{ host_headers = ["motor-lead-api-dev.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 119

      actions = [{
        type               = "forward"
        target_group_index = 19
      }]

      conditions = [{ host_headers = ["posdevapi.gromoinsure.in"] }]
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
      name                              = "gromo-hi-frontend-dev"
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
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    } ,
     {
      name                              = "gromo-hi-facade-dev"
      protocol                          = "HTTP"
      port                              = 3001
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port="3001"
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
      name                              = "gromo-insure-motor-nextjs-dev"
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
      name                              = "gromo-fourwheeler-insurance-dev"
      protocol                          = "HTTP"
      port                              = 3006
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "3006"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health"
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
      name                              = "gromo-twowheeler-nextjs-dev"
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
        path                = "/ping"
        # port                = "80"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }

      protocol_version = "HTTP1"

    },
    {
      name                              = "gromo-tw-motor-insurance-dev"
      protocol                          = "HTTP"
      port                              = 5050
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      backend_port= "5050"
      backend_protocol = "HTTP"
      health_check = {
        enabled             = true
        interval            = 30
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
      name                              = "reconciliation-dev-new"
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
      certificate_arn = data.aws_acm_certificate.amazon_issued.arn
      action_type     = "forward"
      # action_type = "fixed-response"
      target_group_index = "0"
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

      conditions = [{ host_headers = ["hidev.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 101

      actions = [{
        type               = "forward"
        target_group_index = 1
      }]

      conditions = [{ host_headers = ["hifrontenddevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 102

      actions = [{
        type               = "forward"
        target_group_index = 2
      }]

      conditions = [{ host_headers = ["motor-dev.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 103

      actions = [{
        type               = "forward"
        target_group_index = 3
      }]

      conditions = [{ host_headers = ["mv-dev.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 104

      actions = [{
        type               = "forward"
        target_group_index = 4
      }]

      conditions = [{ host_headers = ["twdev.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 105

      actions = [{
        type               = "forward"
        target_group_index = 5
      }]

      conditions = [{ host_headers = ["twdevapi.gromoinsure.in"] }]
    },
    {
      https_listener_index = 0
      priority             = 106

      actions = [{
        type               = "forward"
        target_group_index = 6
      }]

      conditions = [{ host_headers = ["recon-dev.gromoinsure.in"] }]
    }
  ] 

  tags    = local.common_tags
}
