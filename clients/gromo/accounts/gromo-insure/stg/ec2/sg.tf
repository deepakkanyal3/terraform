locals {
  #********************************************************************************
  # Ingress
  #********************************************************************************
  # CIDRs
  ingress_app_common_cidr = [
    {
      # allowed 80 - everyone
      name        = "ssh"
      description = "allows ssh from appbackend jenkins"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = var.jenkins_server_cidr
      type        = "ingress"
    },

    {
        # allows https
      name        = "allow_all"
      description = "allows all traffic central account"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      type        = "ingress"
      cidr_block  = var.central_account_cidr
    }
  ]

  ingress_prod_cidr = [
      {
        # allowed 80 - everyone
        name        = "ssh"
        description = "allows ssh from appbackend jenkins"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_block  = var.central_account_cidr
        type        = "ingress"
      },
    ]

    ingress_insure_cidr = [
      {
        # allowed 80 - everyone
        name        = "http"
        description = "allows http for insure cidr"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = var.vpc_cidr_insure
        type        = "ingress"
      },
    ]

    ingress_nlb = [
      {
        name        = "http"
        description = "allows traffic from nlb"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = var.vpc_cidr_insure
        type        = "ingress"
      },
    ]

    ingress_source-sg = [
        {
                    # Additional rule to allow traffic from ALB security group
         name               = "allow_alb"
         description        = "allows traffic from ALB security group"
         from_port          = 0  # Adjust the source port as needed
         to_port            = 0  # Adjust the destination port as needed
         protocol           = "-1"
         type               = "ingress"
         #security_group_id  = module.sg.sg-id
         #cidr_block         = var.private_alb_sg
         source_security_group_id = var.private_alb_sg
       },
       {
                           # Additional rule to allow traffic from ALB security group
        name               = "allow_alb"
        description        = "allows traffic from Public ALB security group"
        from_port          = 0  # Adjust the source port as needed
        to_port            = 0  # Adjust the destination port as needed
        protocol           = "-1"
        type               = "ingress"
        #security_group_id  = module.sg.sg-id
        #cidr_block         = var.private_alb_sg
        source_security_group_id = var.public_alb_sg
       }
    ]

  #********************************************************************************
  # Egress
  #********************************************************************************
  # CIDRs
  egress_app_common_cidr = [
    {
      # allows https
      name        = "allow_all"
      description = "allows all traffic to everywhere"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      type        = "egress"
      cidr_block  = "0.0.0.0/0"
    }
  ]

  egress_prod_cidr = [
      {
        # allows https
        name        = "allow_all"
        description = "allows all traffic to everywhere"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        type        = "egress"
        cidr_block  = "0.0.0.0/0"
      }
    ]
}

#********************************************************************************
#tfsec:ignore:aws-ec2-add-description-to-security-group
#tfsec:ignore:aws-ec2-no-public-egress-sgr
module "sg" {
  source            = "../../../../../../modules/security_group"
  name = "health"
  vpc_id = data.aws_vpc.current_vpc.id
  environment       = var.environment
  account = var.account
  tags              = local.common_tags
  #ingress_cidr      = local.ingress_prod_cidr
  ingress_source-sg = local.ingress_source-sg
  egress_cidr       = local.egress_prod_cidr
}
#tfsec:ignore:aws-ec2-no-public-egress-sgr
#tfsec:ignore:aws-ec2-add-description-to-security-group
module "sg-2" {
  source            = "../../../../../../modules/security_group"
  name = "two-wheeler"
  vpc_id = data.aws_vpc.current_vpc.id
  environment       = var.environment
  account = var.account
  tags              = local.common_tags
  #ingress_cidr      = local.ingress_prod_cidr
  ingress_source-sg = local.ingress_source-sg
  # ingress_cidr = local.ingress_insure_cidr
  egress_cidr       = local.egress_prod_cidr

}
#tfsec:ignore:aws-ec2-no-public-egress-sgr
#tfsec:ignore:aws-ec2-add-description-to-security-group
module "sg-3" {
  source            = "../../../../../../modules/security_group"
  name = "appbackend"
  vpc_id = data.aws_vpc.current_vpc.id
  environment       = var.environment
  account = var.account
  tags              = local.common_tags
  ingress_source-sg = local.ingress_source-sg
  #ingress_cidr      = local.ingress_prod_cidr
  egress_cidr       = local.egress_prod_cidr

}
#tfsec:ignore:aws-ec2-no-public-egress-sgr
#tfsec:ignore:aws-ec2-add-description-to-security-group
module "sg-4" {
  source            = "../../../../../../modules/security_group"
  name = "four-wheeler"
  vpc_id = data.aws_vpc.current_vpc.id
  environment       = var.environment
  account = var.account
  tags              = local.common_tags
  #ingress_cidr      = local.ingress_prod_cidr
  ingress_source-sg = local.ingress_source-sg
  # ingress_cidr = local.ingress_insure_cidr
  egress_cidr       = local.egress_prod_cidr

}
# module "sg-4" {
#   source            = "../../../../../../modules/security_group"
#   name = "prod-appbackend"
#   vpc_id = data.aws_vpc.current_vpc.id
#   environment       = var.environment
#   account = var.account
#   tags              = local.common_tags
#   ingress_source-sg = local.ingress_source-sg
#   egress_cidr       = local.egress_prod_cidr

# }

# module "sg-5" {
#   source            = "../../../../../../modules/security_group"
#   name = "offline"
#   vpc_id = data.aws_vpc.current_vpc.id
#   environment       = var.environment
#   account = var.account
#   tags              = local.common_tags
#   ingress_source-sg      = local.ingress_source-sg
#   egress_cidr       = local.egress_prod_cidr

# }
#tfsec:ignore:aws-ec2-no-public-egress-sgr
#tfsec:ignore:aws-ec2-add-description-to-security-group
module "app-common" {
  source            = "../../../../../../modules/security_group"
  name = "app-common"
  vpc_id = data.aws_vpc.current_vpc.id
  environment       = var.environment
  account = var.account
  tags              = local.common_tags
  ingress_cidr      = local.ingress_app_common_cidr
  egress_cidr       = local.egress_app_common_cidr
}