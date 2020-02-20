//module "eks" {
//  source       = "aws_eks"
//  cluster-name = "${var.cluster-name}"
//
//  eks-cw-logging = "false"
//  vpc-subnet-cidr = "${var.public_subnets}"
//  sub_id = "${module.eks-vpc.sub_id}"
//  sg_id = "${module.eks-vpc.sg_id}"
//
//}
//
////module "worker_nodes" {
////  source = "eks_node_groups"
////  eks-cw-logging = "false"
////  cluster-name = "${module.eks.cluster_name}"
////  sub_id = "${module.eks-vpc.sub_id}"
////  node_group_name = "${var.node_group_name}"
////  sg_node = "${module.eks-vpc.sg_node}"
////  user_data          = "${base64encode(local.main-node-userdata)}"
////}
//
//
//locals {
//  main-node-userdata = <<USERDATA
//#!/bin/bash
//set -o xtrace
///etc/eks/bootstrap.sh --apiserver-endpoint "${module.eks.endpoint}" --b64-cluster-ca "${module.eks.kubeconfig-certificate-authority-data}" '${module.eks.cluster_name}'
//USERDATA
//}