# locals {
#   #********************************************************************************
#   # Ingress
#   #********************************************************************************
#   # CIDRs
#   ingress_app_sg_cidr = [
#     {
#       # allowed 1192 - everyone
#       name        = "vpn_port_1192"
#       description = "allows 1192 tcp for everyone for vpn"
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_block  = "0.0.0.0/0"
#       type        = "ingress"
#     }
#     ]

#   #********************************************************************************
#   # Egress
#   #********************************************************************************
#   # CIDRs
#   egress_app_sg_cidr = [
#     {
#       # allows https
#       name        = "allow_all"
#       description = "allows all traffic to everywhere"
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       type        = "egress"
#       cidr_block  = "0.0.0.0/0"
#     }
#   ]
# }
# #********************************************************************************
# #tfsec:ignore:aws-ec2-no-public-ingress-sgr
# #tfsec:ignore:aws-ec2-no-public-egress-sgr
# #tfsec:ignore:aws-ec2-no-public-ingress-sgr
# #tfsec:ignore:aws-ec2-add-description-to-security-group
# module "sg" {
#   source            = "../../../../../../modules/security_group"
#   name = "firewall-ec2-sg"
#   vpc_id = data.aws_vpc.current_vpc.id
#   environment               = var.environment
#   account = var.account
#   tags              = local.common_tags
#   ingress_cidr      = local.ingress_app_sg_cidr
#   # ingress_source-sg = local.ingress_source-sg
#   egress_cidr       = local.egress_app_sg_cidr

# }