//locals {
//  main-node-userdata = <<USERDATA
//#!/bin/bash
//set -o xtrace
///etc/eks/bootstrap.sh --apiserver-endpoint "${module.eks.endpoint}" --b64-cluster-ca "${module.eks.kubeconfig-certificate-authority-data}" '${module.eks.cluster_name}'
//USERDATA
//}
