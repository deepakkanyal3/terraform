locals {
  #********************************************************************************
  # Ingress
  #********************************************************************************
  # CIDRs
  

  #   {
  #       # allows https
  #     name        = "allow_all"
  #     description = "allows all traffic central account"
  #     from_port   = 0
  #     to_port     = 0
  #     protocol    = "-1"
  #     type        = "ingress"
  #     cidr_block  = var.central_account_cidr
  #   }
  # ]

  # ingress_prod_cidr = [
  #     {
  #       # allowed 80 - everyone
  #       name        = "ssh"
  #       description = "allows ssh from appbackend jenkins"
  #       from_port   = 22
  #       to_port     = 22
  #       protocol    = "tcp"
  #       cidr_block  = var.central_account_cidr
  #       type        = "ingress"
  #     },
  #   ]

  ingress_windows_cidr = [
      {
        # allowed 80 - everyone
        name        = "RDP"
        description = ""
        from_port   = 3389
        to_port     = 3389
        protocol    = "tcp"
        cidr_block  = var.central_account_cidr
        type        = "ingress"
      },
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
#tfsec:ignore:aws-ec2-no-public-egress-sgr
#tfsec:ignore:aws-ec2-add-description-to-security-group
#tfsec:ignore:aws-ec2-add-description-to-security-group-rule
module "sg" {
  source            = "../../../../../../modules/security_group"
  name = "it-team-sg"
  vpc_id = data.aws_vpc.current_vpc.id
  environment       = var.environment
  account = var.account
  tags              = local.common_tags
  ingress_cidr      = local.ingress_windows_cidr
  #ingress_source-sg = local.ingress_source-sg
  egress_cidr       = local.egress_prod_cidr
}
