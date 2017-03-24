resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.vpc_spot.id}"
}

resource "aws_route" "public_internet_access" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
  route_table_id         = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = "${aws_subnet.public_vpc_spot_a.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.vpc_spot.id}"
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = "${aws_subnet.private_vpc_spot_a.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}
