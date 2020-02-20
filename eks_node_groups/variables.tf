variable "cluster-name" {
  type        = "string"
  description = "cluster name"

}
variable "node_group_name" {
  type  = "string"
  description = "Worker node group name"
}

variable "eks-cw-logging" {
  type = "string"
}

variable "sub_id" {
  default = [""]
}

variable "sg_node" {
  type = "list"
}

variable "user_data" {
  type = "string"
}