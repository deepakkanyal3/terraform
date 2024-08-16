variable "AWS_REGION" {
  type        = string
  description = "Provide region in which to deploy TF code"
}

variable "credentials_profile_name" {
  type        = string
  description = "Name of the AWS credentials profile name to use."
}

variable "account" {
  type    = string
}

variable "environment" {
  type    = string
}

variable "vpc_cidr" {
  type        = string
}

data "aws_vpc" "current_vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.account}-vpc-${var.environment}"]
  }
}

locals {
  common_tags = {
    Project         = "${var.account}_project"
  }
}



variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = null
}

# variable "storage_type" {
#   description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (new generation of general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. If you specify 'io1' or 'gp3' , you must also include a value for the 'iops' parameter"
#   type        = string
#   default     = null
# }

# variable "storage_throughput" {
#   description = "Storage throughput value for the DB instance. This setting applies only to the `gp3` storage type. See `notes` for limitations regarding this variable for `gp3`"
#   type        = number
#   default     = null
# }

# variable "storage_encrypted" {
#   description = "Specifies whether the DB instance is encrypted"
#   type        = bool
#   default     = true
# }
#
# variable "kms_key_id" {
#   description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
#   type        = string
#   default     = null
# }
#



variable "iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  type        = bool
  default     = false
}






variable "db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = null
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = null
}

variable "password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
  default     = null
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = null
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
  type        = string
  default     = null
}


variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = null
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  type        = string
  default     = null
}

variable "availability_zone_a" {
  description = "The Availability Zone of the RDS instance"
  type        = string
  default     = "ap-south-1a"
}

variable "availability_zone_b" {
  description = "The Availability Zone of the RDS instance"
  type        = string
  default     = "ap-south-1b"
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1' or `gp3`. See `notes` for limitations regarding this variable for `gp3`"
  type        = number
  default     = null
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = null
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "character_set_name" {
  description = "The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS and Collations and Character Sets for Microsoft SQL Server for more information. This can only be set on creation."
  type        = string
  default     = null
}


variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  type        = bool
  default     = false
}
#
#
# variable "restore_to_point_in_time" {
#   description = "Restore to a point in time (MySQL is NOT supported)"
#   type        = map(string)
#   default     = null
# }
#
# variable "network_type" {
#   description = "The type of network stack"
#   type        = string
#   default     = null
# }

################################################################################
# CloudWatch Log Group
################################################################################

# variable "create_cloudwatch_log_group" {
#   description = "Determines whether a CloudWatch log group is created for each `enabled_cloudwatch_logs_exports`"
#   type        = bool
#   default     = false
# }
#
# variable "cloudwatch_log_group_retention_in_days" {
#   description = "The number of days to retain CloudWatch logs for the DB instance"
#   type        = number
#   default     = 7
# }
#
# variable "cloudwatch_log_group_kms_key_id" {
#   description = "The ARN of the KMS Key to use when encrypting log data"
#   type        = string
#   default     = null
# }

variable "name" {
  description = "The name of the DB subnet group"
  type        = string
  default     = "prod-subnet-group"
}

variable "description" {
  description = "The description of the DB subnet group"
  type        = string
  default     = null
}

variable "security" {
  description = "The name of the DB subnet group"
  type        = string
  default     = "prod-subnet-group"
}

data "aws_subnet" "intra_subnet_a" {
  filter {
    name   = "tag:Name"
    values = ["*a"]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.current_vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["*intra*"]
  }
}

data "aws_subnet" "intra_subnet_b" {
  filter {
    name   = "tag:Name"
    values = ["*b"]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.current_vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["*intra*"]
  }
}

data "aws_db_snapshot" "snapshot_new" {
  #most_recent            = true
  db_snapshot_identifier = "arn:aws:rds:ap-south-1:360751932080:snapshot:insurance-db-prod-latest"
}

# variable "family" {
#   description = "Parameter group family (engine and version)"
# }
#
# variable "parameter" {
#   description = "List containing parameters to include in the parameter group"
#   type = list(object({
#     apply_method = optional(string, "pending-reboot")
#     name         = string
#     value        = string
#   }))
#
#   # Validate subnet_type (if specified).
#
#   validation {
#     condition     = alltrue([for p in var.parameter : contains(["immediate", "pending-reboot"], p.apply_method)])
#     error_message = "The 'apply_method' specified in the 'parameter' block is not one of the valid values 'immediate' or 'pending_reboot'."
#   }
# }
#
# variable "prefix" {
#   description = "Prefix for parameter group name"
# }
variable "ec2-common-sg" {
  type = string
  default = "sg-02ab2677b1d7df0b3"
  
}



data "aws_caller_identity" "current" {}