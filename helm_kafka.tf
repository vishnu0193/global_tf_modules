//resource "helm_release" "install_kafka" {
//  //count     = "${var.install_kafka == "true" ? 1 : 0}"
//  name      = "kafka-testing"
//  chart     = "bitnami/kafka"
//  namespace = "kafka"
//
//}