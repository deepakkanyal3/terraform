locals {
  network_acls = {

    default_inbound = [
      {
        rule_number = 900
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
    ]
    default_outbound = [
      {
        rule_number = 900
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
    ]

    public_inbound = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 200
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 300
        rule_action = "allow"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      }
    ]
    public_outbound = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 200
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 300
        rule_action = "allow"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      }
    ]

    private_inbound = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = var.vpc_cidr
      },
      {
        rule_number = 200
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = var.vpc_cidr
      },
      {
        rule_number = 300
        rule_action = "allow"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_block  = var.vpc_cidr
      },
      {
        rule_number = 400
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = var.vpc_cidr
      },
      {
        rule_number = 500
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "-1"
        cidr_block  = var.central_account_cidr
      },
      {
        rule_number = 600
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "-1"
        cidr_block  = var.appback_new_vpc_cidr
      },
      {
        rule_number = 800
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "-1"
        cidr_block  = var.appback_vpc_cidr
      },
      {
        rule_number = 700
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "-1"
        cidr_block  = var.insure_vpc_cidr
      },
      {
        rule_number = 800
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = var.appback_vpc_cidr
      },
      
      {
        rule_number = 1000
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = var.new_insurance_stg_vpc_cidr
      },

    ]
    private_outbound = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 200
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 300
        rule_action = "allow"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 400
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = var.vpc_cidr
      },
      {
        rule_number = 500
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "-1"
        cidr_block  = var.central_account_cidr
      }
    ]

    intra_inbound  = []
    intra_outbound = []

  }
}