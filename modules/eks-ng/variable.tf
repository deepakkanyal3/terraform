#**************************************************************************************
# ENV & Tags
#**************************************************************************************

variable "environment" {
  type        = string
  description = "Enter the Environment in which to be deplyed"
}
variable "account" {
  type        = string
}
variable "tags" {}
variable "vpc_id" {
  type = string
}

#**************************************************************************************
# EKS Cluster Related variables
#**************************************************************************************
variable "name" {}

# NG
variable "node_desired_size" {}
variable "node_max_size" {}
variable "node_min_size" {}
variable "node_max_unavailable" {}
variable "node_ami_type" {}
variable "node_capacity" {}
variable "node_disk_size" {}
variable "node_instance_types" {}

variable "node_group_labels" {
  description = "A map of labels to apply to the EKS node group"
  type        = map(string)
  default     = {}
}
variable "eks_iam" {}
variable "eks_cluster" {}


# Launch Template:
# variable "use_custom_launch_template" {
#   description = "Determines whether to use a custom launch template or not. If set to `false`, EKS will use its own default launch template"
#   type        = bool
#   default     = true
# }
# variable "launch_template_id" {
#   description = "The ID of an existing launch template to use. Required when `create_launch_template` = `false` and `use_custom_launch_template` = `true`"
#   type        = string
#   default     = ""
# }
variable "lt_version" {}


#**************************************************************************************
# EKS Cluster Subnets
#**************************************************************************************
# These subnets will come from VPC modules
variable "subnet_ids" {}
#variable "k8s_aws-auth_configmap" {}
data "aws_caller_identity" "current" {}


variable node_group_name {
  type        = string
  default     = "eks"
  description = "description"
}

variable "allow_taints" {
  description = "Flag to determine whether to apply taints or not"
  type        = bool
  default     = false
}

variable "node_taints" {
  description = "List of taints to apply to the node group"
  type        = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default = []
}
