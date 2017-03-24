variable "aws_profile" {}

variable "region" {
  default = "eu-west-2"
}

variable "availability_zone" {}

output "ec2_bootstrap_profile_name" {
  value = "${aws_iam_instance_profile.bootstraping_Ec2_profile.name}"
}
