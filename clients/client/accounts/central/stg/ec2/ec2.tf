# # #tfsec:ignore:aws-ec2-enforce-http-token-imds
# module "server-01" {
#   source                 = "../../../../../../modules/ec2"
#   name                   = "firewall-private-01"
#   ami                    = var.ubuntu_linux_ami
#   instance_type          = "t3a.small"
#   key_name               = var.pem_key
#   account = var.account 
#   vpc_security_group_ids = [module.sg.sg-id]
#   subnet_id              = data.aws_subnet.private_subnet_a.id
#   root_block_device = [
#     {
#       encrypted   = true
#       volume_type = "gp3"
#       throughput  = 200
#       volume_size = 10
#     }
#   ]
#   tags = local.common_tags
#   environment = var.environment
# }

