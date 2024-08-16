locals {
  #********************************************************************************
  # Ingress
  #********************************************************************************
  # CIDRs


  ingress_prod_cidr = [
      {
        # allowed 80 - everyone
        name        = "ssh"
        description = "allows ssh from appbackend jenkins"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_block  = "10.120.0.0/16"
        type        = "ingress"
      }
    ]
    ingress_ec2_cidr = [
      {
        # allowed 80 - everyone
        name        = "allow_ec2"
        description = "allows ec2 security groups"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        source_security_group_id  = var.ec2-common-sg
        type        = "ingress"
      }
    ]

  #********************************************************************************
  # Egress
  #********************************************************************************
  # CIDRs

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
module "rds-sg" {
  source            = "../../../../../../modules/security_group"
  name = "rds-sg"
  vpc_id = data.aws_vpc.current_vpc.id
  environment       = var.environment
  account = var.account
  tags              = local.common_tags
  ingress_cidr      = local.ingress_prod_cidr
  ingress_source-sg     = local.ingress_ec2_cidr
  egress_cidr       = local.egress_prod_cidr

}