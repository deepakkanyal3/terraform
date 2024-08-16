locals {
  engine            = "mysql"
  engine_version    = "8.0.33"
  instance_class    = "db.t4g.small"
  allocated_storage = 100
  port              = "3306"
}


#tfsec:ignore:aws-rds-enable-performance-insights
module "db" {
  source = "../../../../../../modules/rds"

  identifier = "insurance-db-prod"

  engine            = local.engine
  engine_version    = local.engine_version
  instance_class    = local.instance_class
  allocated_storage = local.allocated_storage
  storage_type      = "gp3"

  #db_name  = "demodb"
  username = "admin"
  password = "RvfG2gvMTSwhYC2N"
  port     = local.port

  availability_zone   = var.availability_zone_a
  multi_az            = var.multi_az
  db_subnet_group_name = "prod-subnet-group"
  parameter_group_name = "insure-prod-group"
  #iops                = "3000"
  #storage_throughput  = var.storage_throughput
  publicly_accessible = var.publicly_accessible
  iam_database_authentication_enabled = false
  vpc_security_group_ids = [module.rds-sg.sg-id]
  backup_retention_period = 7
  skip_final_snapshot     = false
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  ca_cert_identifier = "rds-ca-rsa4096-g1"

  account = var.account
  environment = var.environment

  # Database Deletion Protection
  deletion_protection = true
}


############
# Replica DB
############
# module "replica" {
#   source = "../../../../../../modules/rds"
#
#   identifier = "insurance-db-prod-read-replica"
#
#   # Source database. For cross-region use this_db_instance_arn
#   replicate_source_db = module.db.db_instance_id
#
#   engine            = local.engine
#   engine_version    = local.engine_version
#   instance_class    = local.instance_class
#   #allocated_storage = local.allocated_storage
#   skip_final_snapshot     = true
#   storage_type      = "gp3"
#
#   # Username and password should not be set for replicas
#   username = "admin"
#   password = "RvfG2gvMTSwhYC2N"
#   port     = local.port
#
#     availability_zone   = var.availability_zone_b
#     multi_az            = var.multi_az
#     parameter_group_name = "insure-prod-group"
#     #iops                = var.iops
#     #storage_throughput  = var.storage_throughput
#     publicly_accessible = var.publicly_accessible
#     iam_database_authentication_enabled = false
#     vpc_security_group_ids = [module.rds-sg.sg-id]
#
#     maintenance_window = "Mon:00:00-Mon:03:00"
#     backup_window      = "03:00-06:00"
#
#
#     account = var.account
#     environment = var.environment
#
#     # Database Deletion Protection
#     deletion_protection = false
#
# }

# resource "aws_db_instance_automated_backups_replication" "default" {
#   source_db_instance_arn = module.db.db_instance_arn
#   retention_period       = 7
# }