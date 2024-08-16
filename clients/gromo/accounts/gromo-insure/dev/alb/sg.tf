locals {
  #********************************************************************************
  # Ingress
  #********************************************************************************
  # CIDRs
  ingress_alb_sg_cidr = [
    {
      # allowed 80 - everyone
      name        = "http"
      description = "allows http from all"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      type        = "ingress"
    },
    {
      # allowed 443 - everyone
      name        = "http"
      description = "allows https from all"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      type        = "ingress"
    }
  ]


  #********************************************************************************
  # Egress
  #********************************************************************************
  # CIDRs
  egress_alb_sg_cidr = [
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
#tfsec:ignore:aws-ec2-no-public-ingress-sgr
#tfsec:ignore:aws-ec2-no-public-egress-sgr
module "pub_alb_sg" {
  source            = "../../../../../../modules/security_group"
  name = "pub_alb"
  vpc_id = data.aws_vpc.current_vpc.id
  environment               = var.environment
  account = var.account
  tags              = local.common_tags
  ingress_cidr      = local.ingress_alb_sg_cidr
  egress_cidr       = local.egress_alb_sg_cidr

}
#tfsec:ignore:aws-ec2-no-public-ingress-sgr
#tfsec:ignore:aws-ec2-no-public-egress-sgr
#tfsec:ignore:aws-ec2-add-description-to-security-group
module "pvt_alb_sg" {
  source            = "../../../../../../modules/security_group"
  name = "pvt_alb"
  vpc_id = data.aws_vpc.current_vpc.id
  environment               = var.environment
  account = var.account
  tags              = local.common_tags
  ingress_cidr      = local.ingress_alb_sg_cidr
  egress_cidr       = local.egress_alb_sg_cidr

}