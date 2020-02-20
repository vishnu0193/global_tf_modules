variable "cluster-name" {
    type        = "string"
    description = "cluster name"

}
variable "vpc-subnet-cidr" {
  type  = "string"
  description = "subnet cidr range"
}

variable "eks-cw-logging" {
  type = "string"
}



variable "sg_id" {
  default = [""]
}

variable "sub_id" {
  default = [""]
}

