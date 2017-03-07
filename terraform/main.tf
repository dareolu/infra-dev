provider "aws" {
  region =  "${aws_region}"
  profile = "{aws_profile}"
}


resource "aws_instance" "example" {
  ami = "${example_ami}"
  instance_type = "${example_instance_type}"
}
