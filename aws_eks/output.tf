output "endpoint" {
  value = "${aws_eks_cluster.demo.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.demo.certificate_authority}"
}

