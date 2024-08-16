locals {
  #********************************************************************************
  # Ingress
  #********************************************************************************
  # CIDRs
  ingress_app_sg_cidr = [
    {
      # allowed 1192 - everyone
      name        = "vpn_port_1192"
      description = "allows 1192 tcp for everyone for vpn"
      from_port   = 1192
      to_port     = 1192
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      type        = "ingress"
    },
    {
      # allowed 80 - everyone
      name        = "vpn_port_80"
      description = "allows 80 tcp for everyone for vpn"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      type        = "ingress"
    },
    {
      # allowed 443 - everyone
      name        = "vpn_port_443"
      description = "allows 443 tcp for everyone for vpn"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      type        = "ingress"
    },
    {
      # allowed 443 - everyone
      name        = "ssh allow hevo"
      description = "hevo"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "13.235.131.126/32"
      type        = "ingress"
    },
    {
      # allowed 443 - everyone
      name        = "ssh allow iops office ip"
      description = "allows 22 tcp for iops-office for vpn"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "43.247.41.17/32"
      type        = "ingress"
    },
    {
      name        = "ssh allow zoho ip"
      description = "Zoho AB IP 2"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "136.143.178.0/23"
      type        = "ingress"
    },
    {
      name        = "ssh allow zoho ip"
      description = "Insure Zoho Analytics 2"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "103.89.75.23/32"
      type        = "ingress"
    },
    {
      name        = "ssh allow zoho ip"
      description = "Insure Zoho Analytics 5"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "125.17.151.90/32"
      type        = "ingress"
    },
    {
      name        = "ssh allow zoho ip"
      description = "Zoho AB IP 1"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "136.143.176.0/23"
      type        = "ingress"
    },
    {
      name        = "ssh allow zoho ip"
      description = "Insure Zoho Analytics 3"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "154.83.3.41/32"
      type        = "ingress"
    },
    {
      name        = "ssh allow zoho ip"
      description = "Insure Zoho Analytics 1"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "103.89.74.49/32"
      type        = "ingress"
    },
    {
      name        = "ssh allow zoho ip"
      description = "Insure Zoho Analytics 4"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "169.148.146.23/32"
      type        = "ingress"
    }
  ]
  
  ingress_source-sg = [
    {
      # allowed 443 - everyone
      name        = "allow 9100 port for eks sg"
      description = "eks-node-group-sg"
      from_port   = 9100
      to_port     = 9100
      protocol    = "tcp"
      source_security_group_id  = "sg-0dedc5fb2a24c2241"
      type        = "ingress"
    }
  ]

  #********************************************************************************
  # Egress
  #********************************************************************************
  # CIDRs
  egress_app_sg_cidr = [
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
#tfsec:ignore:aws-ec2-no-public-ingress-sgr
#tfsec:ignore:aws-ec2-no-public-egress-sgr
#tfsec:ignore:aws-ec2-add-description-to-security-group
module "sg" {
  source            = "../../../../../../modules/security_group"
  name = var.appname
  vpc_id = data.aws_vpc.current_vpc.id
  environment               = var.environment
  account = var.account
  tags              = local.common_tags
  ingress_cidr      = local.ingress_app_sg_cidr
  ingress_source-sg = local.ingress_source-sg
  egress_cidr       = local.egress_app_sg_cidr

}
