module "efs" {
  source = "../../../../../../modules/efs"

  # File system
  name           = "central-efs"
  creation_token = "central-token"
  encrypted      = true
  kms_key_arn    = "arn:aws:kms:ap-south-1:428538612096:key/555d9c2c-ff60-4bb6-9f87-44a08e145e9b"

  #performance_mode                = "maxIO"
  #throughput_mode                 = "provisioned"
  #provisioned_throughput_in_mibps = 256
  tags    = local.common_tags
  account = var.account
  environment = var.environment

  attach_policy = false
    # Mount targets / security group
     mount_targets = {
       "ap-south-1a" = {
         subnet_id = data.aws_subnet.private_subnet_a.id
       }
        "ap-south-1b" = {
          subnet_id = data.aws_subnet.private_subnet_b.id
        }
       "ap-south-1c" = {
         subnet_id = data.aws_subnet.private_subnet_c.id
       }
     }
     security_group_description = "EFS security group"
     security_group_vpc_id      = module.vpc.vpc_id
     security_group_rules = {
       vpc = {
             # relying on the defaults provdied for EFS/NFS (2049/TCP + ingress)
         description = "NFS ingress from VPC cidr"
         cidr_blocks = [var.vpc_cidr]
       }
     }

      # Access point(s)
       access_points = {
          jenkins = {
            root_directory = {
              path = "/jenkins"
              creation_info = {
                owner_uid = 1000
                owner_gid = 1000
                permissions = 777
              }
            }
            posix_user = {
              uid = 1000
              gid = 1000
            }
          }
       }
#          root = {
#            root_directory = {
#              path = "/"
#            }
#          }



}
