//provider "aws" {
//  region = "us-east-1"
//}
//provider "kubernetes" {
//  version                = "1.7.0"
//  load_config_file       = false
//  host                   = "${module.eks.endpoint}"
//  cluster_ca_certificate = "${base64decode(module.eks.kubeconfig-certificate-authority-data)}"
//}
//
//provider "helm" {
//
//  kubernetes {
//    host                   = "${module.eks.endpoint}"
//    cluster_ca_certificate = "${base64decode(module.eks.kubeconfig-certificate-authority-data)}"
//  }
//}