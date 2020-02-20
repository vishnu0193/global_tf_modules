module "eks" {
  source       = "aws_eks"
  cluster-name = "${var.cluster-name}"

  eks-cw-logging = "false"
  vpc-subnet-cidr = "${var.public_subnets}"
  sub_id = "${module.eks-vpc.sub_id}"
  sg_id = "${module.eks-vpc.sg_id}"


}
