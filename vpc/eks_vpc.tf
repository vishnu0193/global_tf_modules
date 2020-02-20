
data "aws_availability_zones" "available" {
}
resource "aws_vpc" "eks_vpc" {

  cidr_block           = "${var.vpc_cidr}"
  instance_tenancy     = "${var.instance_tenancy}"
  tags = {
    name = "test"
  }

}

###################
# Internet Gateway
###################
resource "aws_internet_gateway" "eks_igw" {


  vpc_id = "${aws_vpc.eks_vpc.id}"

  tags = {
    Name = "terraform-eks-demo"
  }
}

################
# Publiс routes
################
resource "aws_route_table" "public" {

  vpc_id = "${aws_vpc.eks_vpc.id}"

}

resource "aws_route" "public_internet_gateway" {

  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.eks_igw.id}"

  timeouts {
    create = "5m"
  }
}
################
# Public subnet
################
resource "aws_subnet" "public" {

  count = "2"
  vpc_id     = "${aws_vpc.eks_vpc.id}"
  cidr_block = "${var.public_subnets[count.index]}"
  availability_zone= "${data.aws_availability_zones.available.names[count.index]}"
tags = {
    Name = "Main"
  }
}

resource "aws_route_table_association" "public" {

  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}


resource "aws_security_group" "demo-cluster" {
  name        = "terraform-eks-demo-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.eks_vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-demo"
  }
}

resource "aws_security_group_rule" "demo-cluster-ingress-workstation-https" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.demo-cluster.id}"
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = "${aws_vpc.eks_vpc.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}

output "sub_id" {
  value = ["${aws_subnet.public.*.id}"]
}
output "sg_id" {
  value = ["${aws_security_group.demo-cluster.id}"]
}