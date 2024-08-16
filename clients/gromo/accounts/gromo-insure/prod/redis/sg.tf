locals {
  #********************************************************************************
  # Ingress
  #********************************************************************************
  # CIDRs

  ingress_allow = [
    {
      # allowed 6379 - everyone
      name        = "redis"
      description = "allows redis access"
      from_port   = 6379
      to_port     = 6379
      protocol    = "tcp"
      cidr_block  = "10.120.0.0/16"
      type        = "ingress"
    }
  ]

  # Additional rule to allow traffic from EC2 security group
  ingress_source-sg = [
    {
      name               = "allow_ec2"
      description        = "allows traffic from EC2 security group"
      from_port          = 6379  # Adjust the source port as needed
      to_port            = 6379 # Adjust the destination port as needed
      protocol           = "-1"
      type               = "ingress"
      #security_group_id  = module.sg.sg-id
      #cidr_block         = var.private_alb_sg
      source_security_group_id = var.ec2-sg-common-id
    }
  ]

  #********************************************************************************
  # Egress
  #********************************************************************************
  # CIDRs
  egress_allow = [
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
module "sg-redis" {
  source            = "../../../../../../modules/security_group"
  name = var.sg-name
  vpc_id = data.aws_vpc.current_vpc.id
  environment       = var.environment
  account = var.account
  tags              = local.common_tags
  # ingress_cidr      = local.ingress_allow
  ingress_source-sg = local.ingress_source-sg
  egress_cidr       = local.egress_allow
}