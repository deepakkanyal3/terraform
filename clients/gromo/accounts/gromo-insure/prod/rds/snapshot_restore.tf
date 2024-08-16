# module "db-snapshot-restore" {
#   source = "../../../../../../modules/rds"
#
#   engine                   = "mysql"
#   engine_version           = "8.0.33"
#   identifier                = "db-instance-id"
#   db_name                   = "inurance-prod"
#   instance_class            = "db.t4g.small"
#   skip_final_snapshot       = false
#   snapshot_identifier       = data.aws_db_snapshot.snapshot_new.id
#   storage_encrypted         = true
#   backup_retention_period = 5
#   backup_window           = "07:00-09:00"
#   vpc_security_group_ids = [module.rds-sg.sg-id]
#
#   #maintenance_window = "Tue:05:00-Tue:07:00"
#
#   availability_zone   = var.availability_zone
#   multi_az            = var.multi_az
#   db_subnet_group_name = "prod-subnet-group"
#   publicly_accessible = var.publicly_accessible
#
#
#   account = var.account
#   environment = var.environment
#
# #   tags = {
# #     Owner       = "user"
# #     #account = var.account
# #     #Environment = var.environment
# #   }
#
#   # Database Deletion Protection
#   deletion_protection = false
# }