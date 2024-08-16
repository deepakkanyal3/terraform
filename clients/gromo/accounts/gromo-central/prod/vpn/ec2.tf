locals {
  user_data = <<-EOT
  #!/bin/bash
  sudo tee /etc/yum.repos.d/mongodb-org-6.0.repo << EOF
  [mongodb-org-6.0]
  name=MongoDB Repository
  baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/6.0/x86_64/
  gpgcheck=1
  enabled=1
  gpgkey=https://www.mongodb.org/static/pgp/server-6.0.asc
  EOF

  sudo tee /etc/yum.repos.d/pritunl.repo << EOF
  [pritunl]
  name=Pritunl Repository
  baseurl=https://repo.pritunl.com/stable/yum/amazonlinux/2/
  gpgcheck=1
  enabled=1
  EOF

  sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A
  gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A > key.tmp; sudo rpm --import key.tmp; rm -f key.tmp
  sudo yum -y install pritunl mongodb-org
  sudo systemctl start mongod pritunl
  sudo systemctl enable mongod pritunl
  EOT
}

#tfsec:ignore:aws-ec2-enforce-http-token-imds
module "server-01" {
  source                 = "../../../../../../modules/ec2"
  name                   = "${var.appname}-01"
  ami                    = var.amazon_linux_ami
  instance_type          = "t3a.medium"
  key_name               = var.pem_key
  vpc_security_group_ids = [module.sg.sg-id]
  subnet_id              = data.aws_subnet.public_subnet_a.id
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 100
    }
  ]
  tags                   = local.common_tags
  account = var.account
  environment = var.environment
  user_data = local.user_data
}

resource "aws_eip" "ip-01" {
  vpc = true
  instance                  = module.server-01.id
  depends_on                = [module.server-01]
}