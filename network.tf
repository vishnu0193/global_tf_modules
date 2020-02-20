

# tf file to call the VPC module which creates 2 public subnets
module "eks-vpc" {
  source  = "vpc"
  vpc_cidr = "${var.vpc_cidr}"
  version = "2.6.0"
  instance_tenancy= "${var.instance_tenancy}"
   public_subnets = ["${var.public_subnets}"]
}

