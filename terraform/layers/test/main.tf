provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.region}"
}

resource "aws_instance" "cm-manager" {
  ami               = "${var.ami_id}"
  instance_type     = "${var.instance_type}"
  count             = 1
  availability_zone = "${var.availability_zone}"
  key_name          = "${var.key_name}"

  root_block_device {
    delete_on_termination = true
    volume_size           = "${var.volume_size}"
    volume_type           = "gp2"
  }
}
