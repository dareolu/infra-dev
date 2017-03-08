provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.region}"
}

resource "aws_instance" "DareServer" {
  ami           = "ami-a19782c5"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.DareServer.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.DareServer.id}"
}
