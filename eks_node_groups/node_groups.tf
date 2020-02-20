resource "aws_iam_role" "worker" {
  name = "terraform-eks-main-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.worker.name}"
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.worker.name}"
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = "${aws_iam_role.worker.name}"
}

resource "aws_iam_instance_profile" "main-node" {
  name = "terraform-eks-main"
  role = "${aws_iam_role.worker.name}"
}

resource "aws_eks_node_group" "test_group" {
  cluster_name    = "${var.cluster-name}"
  node_group_name = "${var.node_group_name}"
  node_role_arn   = "${aws_iam_role.worker.arn}"
  subnet_ids      = ["${var.sub_id}"]

scaling_config {
desired_size = 1
max_size     = 1
min_size     = 1
}

# Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
# Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
depends_on = [
"aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy",
"aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy",
"aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly",
]
}