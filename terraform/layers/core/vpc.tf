provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.region}"
}

resource "aws_vpc" "vpc_spot" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.vpc_spot.id}"
  service_name = "com.amazonaws.${var.region}.s3"

  route_table_ids = ["${aws_route_table.private_route_table.id}", "${aws_route_table.public_route_table.id}"]
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc_spot.id}"
}
