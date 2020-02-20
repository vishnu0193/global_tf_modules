//variable "create_vpc" {
//  type  = "string"
//  description = "flag whether vpc is to be enabled or not"
//}

variable "public_subnets" {
  type  = "list"
  description = "number of subnets to be created"
}

variable "vpc_cidr" {
  type  = "string"
  description = "vpc cidr range"
}

variable "instance_tenancy" {
  type = "string"
  description = "dedicated vpc"
  default = "default"

}

variable "public_subnets_tag" {
  type  = "string"
  description = "vpc cidr range"
}

