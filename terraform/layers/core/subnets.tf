resource "aws_subnet" "private_vpc_spot_a" {
  availability_zone       = "${var.region}a"
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = false
  vpc_id                  = "${aws_vpc.vpc_spot.id}"
}

resource "aws_subnet" "public_vpc_spot_a" {
  availability_zone       = "${var.region}a"
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = "${aws_vpc.vpc_spot.id}"
}
