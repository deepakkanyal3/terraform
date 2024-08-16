module "server-01" {
  source                 = "../../../../../../modules/ec2"
  name                   = "${var.appname}-01"
  ami                    = var.amazon_linux_ami
  instance_type          = "t3a.large"
  disable_api_termination = true
  iam_instance_profile    = "ec2_profile"
  key_name               = var.pem_key
  vpc_security_group_ids = [module.sg.sg-id, module.app-common.sg-id]
  subnet_id              = data.aws_subnet.private_subnet_a.id
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 60
    }
  ]

  tags    = local.common_tags
  account = var.account
  environment = var.environment
  #user_data = local.user_data
}

module "server-02" {
  source                 = "../../../../../../modules/ec2"
  name                   = "${var.appname}-02"
  ami                    = var.amazon_linux_ami
  instance_type          = "t3a.large"
  disable_api_termination = true
  iam_instance_profile    = "ec2_profile"
  key_name               = var.pem_key
  vpc_security_group_ids = [module.sg.sg-id, module.app-common.sg-id]
  subnet_id              = data.aws_subnet.private_subnet_a.id
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 60
    }
  ]

  tags    = local.common_tags
  account = var.account
  environment = var.environment
  #user_data = local.user_data
}

module "server-03" {
  source                 = "../../../../../../modules/ec2"
  name                   = "mv-fourwheeler-01"
  ami                    = var.amazon_linux_ami
  instance_type          = "t3a.large"
  disable_api_termination = true
  iam_instance_profile    = "ec2_profile"
  key_name               = var.pem_key
  vpc_security_group_ids = [module.sg-2.sg-id, module.app-common.sg-id]
  subnet_id              = data.aws_subnet.private_subnet_a.id
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 60
    }
  ]

  tags    = local.common_tags
  account = var.account
  environment = var.environment
  #user_data = local.user_data
}

module "server-04" {
  source                 = "../../../../../../modules/ec2"
  name                   = "mv-fourwheeler-02"
  ami                    = var.amazon_linux_ami
  instance_type          = "t3a.large"
  disable_api_termination = true
  iam_instance_profile    = "ec2_profile"
  key_name               = var.pem_key
  vpc_security_group_ids = [module.sg-2.sg-id, module.app-common.sg-id]
  subnet_id              = data.aws_subnet.private_subnet_a.id
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 60
    }
  ]

  tags    = local.common_tags
  account = var.account
  environment = var.environment
  #user_data = local.user_data
}
module "server-05" {
  source                 = "../../../../../../modules/ec2"
  name                   = "two-wheeler-1"
  ami                    = var.amazon_linux_ami
  instance_type          = "t3a.medium"
  disable_api_termination = true
  iam_instance_profile    = "ec2_profile"
  key_name               = var.pem_key
  vpc_security_group_ids = [module.sg-3.sg-id, module.app-common.sg-id]
  subnet_id              = data.aws_subnet.private_subnet_a.id
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 60
    }
  ]

  tags    = local.common_tags
  account = var.account
  environment = var.environment
  #user_data = local.user_data
}
#tfsec:ignore:aws-ec2-enforce-http-token-imds
module "server-06" {
  source                 = "../../../../../../modules/ec2"
  name                   = "two-wheeler-2"
  ami                    = var.amazon_linux_ami
  instance_type          = "t3a.medium"
  disable_api_termination = true
  iam_instance_profile    = "ec2_profile"
  key_name               = var.pem_key
  vpc_security_group_ids = [module.sg-3.sg-id, module.app-common.sg-id]
  subnet_id              = data.aws_subnet.private_subnet_a.id
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 60
    }
  ]

  tags    = local.common_tags
  account = var.account
  environment = var.environment
  #user_data = local.user_data
}
#tfsec:ignore:aws-ec2-enforce-http-token-imds
module "server-07" {
  source                 = "../../../../../../modules/ec2"
  name                   = "appbackend"
  ami                    = var.amazon_linux_ami
  instance_type          = "t3a.medium"
  disable_api_termination = true
  iam_instance_profile    = "ec2_profile"
  key_name               = var.pem_key
  vpc_security_group_ids = [module.sg-4.sg-id, module.app-common.sg-id]
  subnet_id              = data.aws_subnet.private_subnet_a.id
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 60
    }
  ]

  tags    = local.common_tags
  account = var.account
  environment = var.environment
  #user_data = local.user_data
}
#tfsec:ignore:aws-ec2-enforce-http-token-imds
module "server-08" {
  source                 = "../../../../../../modules/ec2"
  name                   = "offline-1"
  ami                    = var.amazon_linux_ami
  instance_type          = "t3a.medium"
  disable_api_termination = true
  iam_instance_profile    = "ec2_profile"
  key_name               = var.pem_key
  vpc_security_group_ids = [module.sg-5.sg-id, module.app-common.sg-id]
  subnet_id              = data.aws_subnet.private_subnet_a.id
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 60
    }
  ]

  tags    = local.common_tags
  account = var.account
  environment = var.environment
  #user_data = local.user_data
}
#tfsec:ignore:aws-ec2-enforce-http-token-imds
module "server-09" {
  source                 = "../../../../../../modules/ec2"
  name                   = "offline-2"
  ami                    = var.amazon_linux_ami
  instance_type          = "t3a.medium"
  disable_api_termination = true
  iam_instance_profile    = "ec2_profile"
  key_name               = var.pem_key
  vpc_security_group_ids = [module.sg-5.sg-id, module.app-common.sg-id]
  subnet_id              = data.aws_subnet.private_subnet_a.id
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 60
    }
  ]

  tags    = local.common_tags
  account = var.account
  environment = var.environment
  #user_data = local.user_data
}
# resource "aws_eip" "ip-01" {
#   vpc = true
#   instance                  = module.server-01.id
#   depends_on                = [module.server-01]
# }