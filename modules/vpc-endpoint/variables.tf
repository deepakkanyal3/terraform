variable "vpc_id" {
  description = "VPC ID"
  type        = string
}


variable route_table_ids {
}

variable environment {
}

variable account {
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}

variable ingress_rules {
  type        = list
  default     = []
  description = "description"
}
variable gateway_endpoint_list {
  type        = list
  default     = []
  description = "description"
}

variable interface_endpoint_list {
  type        = list
  default     = []
  description = "description"
}

