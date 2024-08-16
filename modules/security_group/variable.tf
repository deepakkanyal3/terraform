#**************************************************************************************
# ENV & Tags
#**************************************************************************************

variable "tags" {}
# #**************************************************************************************
# # SG Variables
# #**************************************************************************************
variable "ingress_cidr" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    type        = string
  }))
  default = []
}
variable "ingress_self" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    type        = string
    self        = string
  }))
  default = []
}
variable "ingress_source-sg" {
  type = list(object({
    description              = string
    from_port                = number
    to_port                  = number
    protocol                 = string
    type                     = string
    source_security_group_id = string
  }))
  default = []
}
variable "egress_cidr" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    type        = string
  }))
  default = []
}
variable "egress_self" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    type        = string
    self        = string
  }))
  default = []
}
variable "egress_source-sg" {
  type = list(object({
    description              = string
    from_port                = number
    to_port                  = number
    protocol                 = string
    type                     = string
    source_security_group_id = string
  }))
  default = []
}

data "aws_caller_identity" "current" {}
variable "account" {}
variable "environment" {}
variable "name" {}
variable "vpc_id" {}