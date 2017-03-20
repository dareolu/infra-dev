provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.region}"
}

resource "aws_instance" "cm-manager" {
  ami               = "${var.ami_id}"
  instance_type     = "${var.instance_type}"
  count             = "${var.instance_count}"
  availability_zone = "${var.availability_zone}"
  key_name          = "${var.key_name}"

  root_block_device {
    delete_on_termination = true
    volume_size           = "${var.volume_size}"
    volume_type           = "gp2"
  }
}

#This part to be moved to a centralized location later
resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

#################################################

# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.1.0.0/16"
}

#Create Internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
}

# Create route table
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }
}

# Create Default Route Table
resource "aws_default_route_table" "private" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"
}

#Create public subnet
resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1a"

  tags {
    Name = "public"
  }
}

#Create private1 subnet
resource "aws_subnet" "private1" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-west-1b"

  tags {
    Name = "private1"
  }
}

#Create private2 subnet
resource "aws_subnet" "private2" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.1.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-west-1c"

  tags {
    Name = "private2"
  }
}

#Create RDS1 subnet
resource "aws_subnet" "rds1" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.1.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-west-1a"

  tags {
    Name = "rds1"
  }
}
