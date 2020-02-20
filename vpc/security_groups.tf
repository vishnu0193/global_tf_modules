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
## Security groups for Master node
resource "aws_security_group_rule" "demo-cluster-ingress-workstation-https" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.demo-cluster.id}"
  to_port           = 443
  type              = "ingress"
}

# Security group for worker node-1
resource "aws_security_group" "worker_one" {
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

resource "aws_security_group_rule" "main-node-ingress-self" {
  type              = "ingress"
  description       = "Allow node to communicate with each other"
  from_port         = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.demo-cluster.id}"
  to_port           = 65535
  cidr_blocks       = [
    "${var.public_subnets}"
  ]
}

resource "aws_security_group_rule" "main-node-ingress-cluster" {
  type                     = "ingress"
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.demo-cluster.id}"
  source_security_group_id = "${aws_security_group.worker_one.id}"
  to_port                  = 65535
}
output "sg_id" {
  value = ["${aws_security_group.demo-cluster.id}"]
}

output "sg_node" {
  value = ["${aws_security_group.worker_one.id}"]
}

