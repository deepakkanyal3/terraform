# data "aws_iam_instance_profile" "profile" {
#   name = "ec2_profile"
# }

#tfsec:ignore:aws-ec2-enforce-http-token-imds
module "server-01" {
  source                 = "../../../../../../modules/ec2"
  name                   = "IT-team"
  ami                    = var.windows_ami
  instance_type          = "t3a.medium"
  disable_api_termination = true
  #iam_instance_profile    = data.aws_iam_instance_profile.profile.name
  key_name               = "windows"
  vpc_security_group_ids = [module.sg.sg-id]
  subnet_id              = data.aws_subnet.private_subnet_a.id
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 100
    }
  ]

  tags    = local.common_tags
  account = var.account
  environment = var.environment
  #user_data = local.user_data
}