# bastion sg

resource "aws_security_group" "bastion" {
  name        = "bastion_public"
  description = "Allow Access to Bastion and also used by public and private instances for load balancer access"
  vpc_id      = "${aws_vpc.vpc_spot.id}"

  #SSH RULE

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #HTTP RULE

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #ICMP RULE
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Outbound http access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          #"-1 means from any protocol"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
