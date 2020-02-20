resource "aws_launch_configuration" "main" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.main-node.name}"
  image_id                    = "ami-0d9462a653c34dab7"
  instance_type               = "t2.micro"
  name_prefix                 = "terraform-eks-main"
  security_groups             = ["${var.sg_node}"]
  user_data_base64            = "${var.user_data}"


lifecycle {
  create_before_destroy = true
}
}