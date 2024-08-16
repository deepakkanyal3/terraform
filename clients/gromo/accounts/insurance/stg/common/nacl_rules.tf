locals {
  network_acls = {

    default_inbound = [
    ]
    default_outbound = [
    ]

    public_inbound = [
      {#Allows incoming HTTP traffic from any IP address for LB redirection from port 80 to 443
        rule_number = 100
        rule_action = "allow"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0" 
      },
      {#Allows incoming HTTPS traffic on port 443 from any IP address (0.0.0.0/0) for Application access via LB running in Public Subnet
        rule_number = 200
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"  
      },
      {#Allows incoming TCP traffic from application running in private subnet (EKS) that route traffic via NAT Gateway located in public Subnet
        rule_number = 900
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"  
      }
    ]
    public_outbound = [
      { #Allows outgoing HTTP traffic application running in private subnet (EKS) that route traffic via NAT Gateway communicate depended-servies or thrid-parthy services over the internet 
        rule_number = 100
        rule_action = "allow"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"   
      },
      { #Allows outgoing HTTPS traffic application running in private subnet (EKS) that route traffic via NAT Gateway communicate depended-servies or thrid-parthy services over the internet 
        rule_number = 200
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"    
      },
      { #Allows outbound TCP traffic from application running in private subnet (EKS) that route traffic via NAT Gateway located in public Subnet
        rule_number = 900
        rule_number = 900
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
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
        cidr_block  = var.central_account_cidr
      },
      {
        rule_number = 200
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = var.central_account_cidr
      },
      {
        rule_number = 300
        rule_action = "allow"
        from_port   = var.ssh_port
        to_port     = var.ssh_port
        protocol    = "tcp"
        cidr_block  = var.central_account_cidr #for ssh connection
      },
      {
        rule_number = 400
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = var.new-insure-stg # to communicate from new-insure stg 
      },
      {
        rule_number = 800
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = var.vpc_cidr # this is needed for kubernetes specific communication
      },
      {
        rule_number = 900
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
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
        rule_number = 800
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = var.vpc_cidr # this is needed for kubernetes specific communication
      },
      {
        rule_number = 900
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
    ]

    intra_inbound  = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = var.vpc_cidr # this is needed for kubernetes specific communication
      },
      {
        rule_number = 200
        rule_action = "allow"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_block  = var.central_account_cidr
      },
      {
        rule_number = 300
        rule_action = "allow"
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        cidr_block  = var.central_account_cidr
      },
      {
        rule_number = 400
        rule_action = "allow"
        from_port   = 27017
        to_port     = 27017
        protocol    = "tcp"
        cidr_block  = var.central_account_cidr
      },
      {
        rule_number = 500
        rule_action = "allow"
        from_port   = 6379
        to_port     = 6379
        protocol    = "tcp"
        cidr_block  = var.central_account_cidr
      },
      
    ]
    intra_outbound = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = var.vpc_cidr # this is needed for kubernetes specific communication
      },
      {
        rule_number = 200
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = var.central_account_cidr
      },
      {
        rule_number = 300
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "10.0.0.0/8" # only for gromo as an exception
      },
      {
        rule_number = 400
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "172.31.0.0/16" # only for gromo as an exception
      },
    ]
    
    
  }
}