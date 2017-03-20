provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.region}"
}

resource "aws_instance" "DareServer" {
  ami           = "ami-a19782c5"
  instance_type = "t2.micro"
  count         = 4
}
