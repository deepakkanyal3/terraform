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
# Allows incoming request on vpn on 1192 port from any IP address
      {
        rule_number = 91
        rule_action = "allow"
        from_port   = 1192
        to_port     = 1192
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0" 
      },
# Allows incoming HTTP traffic from any IP address for LB redirection from port 80 to 443
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0" 
      },
# Allows incoming HTTPS traffic on port 443 from any IP address (0.0.0.0/0) 
# for Application access via LB running in Public Subnet
      {
        rule_number = 110
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0" 
      },
# Allows incoming SSH traffic on port 22 only from the IP range 10.200.1.125/32.{ VPN Server }
      {
        rule_number = 200
        rule_action = "allow"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_block  = "10.200.1.125/32" 
      }, 
# SMTP server as prometheus central will use this port used /18 subnet mask range as cidr range (10.200.0.0 - 10.200.63.255)  
      {
        rule_number = 400
        rule_action = "allow"
        from_port   = 25
        to_port     = 25
        protocol    = "tcp"
        cidr_block  = "10.200.0.0/18" 
      },
    ]
    public_outbound = [
# aws ses will communicate with smtp server which is atlantis server {Allows outgoing traffic on port 587, which is used by 
# AWS SES to communicate with SMTP servers.} cant use ses fixed as currently we are shared ip for it and
# and if we need to communicate it more securely then we need to create vpc interface endpoint which will cost us extra amount then we can send our traffic privately.
# Public IPs: Total cost is $10.45 for sending 100,000 emails.
# VPC Interface Endpoint: Total cost is $17.25 for sending 100,000 emails.
# Vpc interface endpoint should be used when we are more focused on security rather then cost and it will also lower down the cost if our data transfer size is large
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
        from_port   = 587
        to_port     = 587   
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0" 
      },                  
# netstat output  10:09:16.061441 IP 192.168.31.34.62458 > 65.0.142.229.443: Flags [.], ack 8437, win 2048, options [nop,nop,TS val 312338229 ecr 1476264029], length 0
# open because for the response back of requests coming from multiple ports (ephermal port range)
      {
        rule_number = 900
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535 
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0" 
      },
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
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.100.0.0/16"
      },
      {
        rule_number = 600
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "172.31.0.0/16"
      },
      {
        rule_number = 700
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.110.0.0/16"
      },
      {
        rule_number = 800
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.111.0.0/16"
      },
      {
        rule_number = 900
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 1000
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.112.0.0/16"
      },
      {
        rule_number = 1001
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.120.0.0/16"
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
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.100.0.0/16"
      },
      {
        rule_number = 900
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      }
    ]

    intra_inbound  = [

      {
        rule_number = 900
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      }
    ]
    intra_outbound = [
      {
        rule_number = 900
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      }
    ]

  }
}
# locals {
#   network_acls = {

#     default_inbound = [
#     ]
#     default_outbound = [
#     ]

#     public_inbound = [ 
# # Allows incoming HTTP traffic from any IP address for LB redirection from port 80 to 443
#       {
#         rule_number = 100
#         rule_action = "allow"
#         from_port   = 80
#         to_port     = 80
#         protocol    = "tcp"
#         cidr_block  = "0.0.0.0/0" 
#       },
# # Allows incoming HTTPS traffic on port 443 from any IP address (0.0.0.0/0) 
# # for Application access via LB running in Public Subnet
#       {
#         rule_number = 110
#         rule_action = "allow"
#         from_port   = 443
#         to_port     = 443
#         protocol    = "tcp"
#         cidr_block  = "0.0.0.0/0" 
#       },
# # Allows incoming SSH traffic on port 22 only from the IP range 10.200.1.125/32.{ VPN Server }
#       {
#         rule_number = 200
#         rule_action = "allow"
#         from_port   = 22
#         to_port     = 22
#         protocol    = "tcp"
#         cidr_block  = "10.200.1.125/32" 
#       }, 
# # SMTP server as prometheus central will use this port used /18 subnet mask range as cidr range (10.200.0.0 - 10.200.63.255)  
#       {
#         rule_number = 400
#         rule_action = "allow"
#         from_port   = 25
#         to_port     = 25
#         protocol    = "tcp"
#         cidr_block  = "10.200.0.0/18" 
#       },
#     ]
#     public_outbound = [
# # aws ses will communicate with smtp server which is atlantis server {Allows outgoing traffic on port 587, which is used by 
# # AWS SES to communicate with SMTP servers.} cant use ses fixed as currently we are shared ip for it and
# # and if we need to communicate it more securely then we need to create vpc interface endpoint which will cost us extra amount then we can send our traffic privately.
# # Public IPs: Total cost is $10.45 for sending 100,000 emails.
# # VPC Interface Endpoint: Total cost is $17.25 for sending 100,000 emails.
# # Vpc interface endpoint should be used when we are more focused on security rather then cost and it will also lower down the cost if our data transfer size is large
#       {
#         rule_number = 300
#         rule_action = "allow"
#         from_port   = 587
#         to_port     = 587   
#         protocol    = "tcp"
#         cidr_block  = "0.0.0.0/0" 
#       },                  
# # netstat output  10:09:16.061441 IP 192.168.31.34.62458 > 65.0.142.229.443: Flags [.], ack 8437, win 2048, options [nop,nop,TS val 312338229 ecr 1476264029], length 0
# # open because for the response back of requests coming from multiple ports (ephermal port range)
#       {
#         rule_number = 900
#         rule_action = "allow"
#         from_port   = 1024
#         to_port     = 65535 
#         protocol    = "tcp"
#         cidr_block  = "0.0.0.0/0" 
#       },
#     ]

#     private_inbound = [
# # Allows all types of traffic from any IP address within the 10.110.0.0/16 subnet {appbackend-stg-vpc-peering account }
#       {
#         rule_number = 100
#         rule_action = "allow"
#         from_port   = 443
#         to_port     = 443
#         protocol    = "tcp"
#         cidr_block  = "10.110.0.0/16" 
#       },
# # Allows all types of traffic from any IP address within the 10.200.0.0/16 subnet.{own tarffic} - this is needed for kubernetes specific communication
#       {
#         rule_number = 200
#         rule_action = "allow"
#         from_port   = 443
#         to_port     = 443
#         protocol    = "tcp"
#         cidr_block  = "10.200.0.0/16" 
#       },
# # Allows all types of traffic from any IP address within the 10.120.0.0/16 subnet.{insurance-prod}
#       {
#         rule_number = 300
#         rule_action = "allow"
#         from_port   = 443
#         to_port     = 443
#         protocol    = "tcp"
#         cidr_block  = "10.120.0.0/16"
#       },
# # Allows all types of traffic from any IP address within the 10.112.0.0/16 subnet.{Insurance-stg-vpc-peerring account}
#       {
#         rule_number = 400
#         rule_action = "allow"
#         from_port   = 443
#         to_port     = 443
#         protocol    = "tcp"
#         cidr_block  = "10.112.0.0/16"
#       },
# # Allows all types of traffic from any IP address within the 10.100.0.0/16 subnet {appbackend-prod-vpc-peering account }
#       {
#         rule_number = 500
#         rule_action = "allow"
#         from_port   = 443
#         to_port     = 443
#         protocol    = "tcp"
#         cidr_block  = "10.100.0.0/16"
#       }, 
# # Allows all types of traffic from any IP address within the 172.31.0.0/16 subnet {appbackend-default-vpc-peering account }
#       {
#         rule_number = 600
#         rule_action = "allow"
#         from_port   = 443
#         to_port     = 443
#         protocol    = "tcp"
#         cidr_block  = "172.31.0.0/16" 
#       },
#     ]
#     private_outbound = [
# # this is needed for kubernetes specific communication
#       {
#         rule_number = 800
#         rule_action = "allow"
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_block  = var.vpc_cidr 
#       },
#     ]

#     intra_inbound  = [
#       {
#         rule_number = 100
#         rule_action = "allow"
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_block  = var.vpc_cidr # this is needed for kubernetes specific communication
#       },
#       {
#         rule_number = 200
#         rule_action = "allow"
#         from_port   = 3306
#         to_port     = 3306
#         protocol    = "tcp"
#         cidr_block  = var.vpc_cidr #Allows incoming TCP traffic on port 3306 from any IP address within the 10.200.0.0/16 {VPN} subnet. - MYSQL
#       },
#       {
#         rule_number = 300
#         rule_action = "allow"
#         from_port   = 5432
#         to_port     = 5432
#         protocol    = "tcp"
#         cidr_block  = var.vpc_cidr #Allows incoming TCP traffic on port 5432 from any IP address within the 10.200.0.0/16 {VPN} subnet. - Postgrace
#       },
#       {
#         rule_number = 400
#         rule_action = "allow"
#         from_port   = 27017
#         to_port     = 27017
#         protocol    = "tcp"
#         cidr_block  = var.vpc_cidr #Allows incoming TCP traffic on port 27017 from any IP address within the 10.200.0.0/16 {VPN} subnet. -   Mongodb
#       },
#       {
#         rule_number = 500
#         rule_action = "allow"
#         from_port   = 6379
#         to_port     = 6379
#         protocol    = "tcp"
#         cidr_block  = var.vpc_cidr #Allows incoming TCP traffic on port 6379 from any IP address within the 10.200.0.0/16 {VPN } subnet.   -    REDIS
#       },
      
#     ]
#     intra_outbound = [
#       {
#         rule_number = 100
#         rule_action = "allow"
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_block  = var.vpc_cidr # this is needed for kubernetes specific communication
#       },
#       {
#         rule_number = 200
#         rule_action = "allow"
#         from_port   = 1024
#         to_port     = 65535
#         protocol    = "tcp"
#         cidr_block  = var.vpc_cidr
#       },
#       # {
#       #   rule_number = 300
#       #   rule_action = "allow"
#       #   from_port   = 1024
#       #   to_port     = 65535
#       #   protocol    = "tcp"
#       #   cidr_block  = "10.0.0.0/8" # only for gromo as an exception
#       # },
#       # {
#       #   rule_number = 400
#       #   rule_action = "allow"
#       #   from_port   = 1024
#       #   to_port     = 65535
#       #   protocol    = "tcp"
#       #   cidr_block  = "172.31.0.0/16" # only for gromo as an exception
#       # },
#     ]    
#   }
# }