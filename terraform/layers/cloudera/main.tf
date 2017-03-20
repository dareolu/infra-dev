provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.region}"
}

resource "aws_instance" "cm-manger" {
  ami           = "ami-a19782c5"
  instance_type = "${var.instance_type}"
}
