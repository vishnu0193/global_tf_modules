
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
    Name = ["${var.public_subnets_tag}"]
  }
}

resource "aws_route_table_association" "public" {

  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

output "sub_id" {
  value = ["${aws_subnet.public.*.id}"]
}
