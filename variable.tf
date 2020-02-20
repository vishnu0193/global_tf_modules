variable "cluster-name" {
  type        = "string"
  description = "cluster name"
  default = "eks-testing"

}

variable "region" {
  type        = "string"
  default     = "ap-south-1"
}

variable "create_vpc" {
  description = "flag whether vpc is to be enabled or not"
  default = "true"
}

variable "public_subnets" {
  type= "list"
  description = "number of subnets to be created"
  default = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "vpc_cidr" {
  type  = "string"
  description = "vpc cidr range"
  default = "10.0.0.0/16"
}

variable "instance_tenancy" {
  type = "string"
  description = "dedicated vpc"
  default = "default"

}
variable "sg_id" {
  type = "list"
  default = [""]
}
variable "sub_id" {
  type = "list"
  default = [""]
}

variable "availability_zones" {
  type = "list"
  default = [
    "ap-south-1a",
    "ap-south-1b"]
}

