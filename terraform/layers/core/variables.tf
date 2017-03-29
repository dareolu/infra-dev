variable "aws_profile" {}

variable "region" {
  default = "eu-west-2"
}

variable "availability_zone" {}

variable "bucket_name" {
  description = "bucket used for terraform remote state"
}

output "subnet_id" {
  value = "${aws_subnet.public_vpc_spot_a.id}"
}

output "vpc_security_group_ids" {
  value = "${aws_security_group.bastion.id}"
}

output "ec2_bootstrap_profile_name" {
  value = "${aws_iam_instance_profile.bootstraping_Ec2_profile.name}"
}
