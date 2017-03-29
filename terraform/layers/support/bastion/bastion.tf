data "template_file" "bootstrap" {
  template = "${file("${path.module}/../../../bin/userdata.sh.tpl")}"

  vars {
    bucket = "putProject_and_Environment_here-infrastructure"
  }
}

data "terraform_remote_state" "infrastructure" {
  backend = "s3"

  config {
    bucket = "${var.state_bucket}"
    key    = "${var.state_file}"
    region = "${var.region}"
  }
}

resource "aws_instance" "bastion" {
  count = "${var.instance_count}"
  ami   = "${var.ami_id}"

  #user_data              = "${data.template_file.bootstrap.rendered}"
  iam_instance_profile   = "${data.terraform_remote_state.infrastructure.ec2_bootstrap_profile_name}"
  subnet_id              = "${data.terraform_remote_state.infrastructure.subnet_id}"
  vpc_security_group_ids = ["${data.terraform_remote_state.infrastructure.vpc_security_group_ids}"]

  #vpc_id                 = "${data.terraform_remote_state.core.aws_vpc.vpc_spot.id}"
  key_name      = "${var.key_name}"
  key_name      = "${aws_key_pair.auth.id}"
  instance_type = "${var.instance_type}"

  #access_from            = ["${var.bastion_access_from}"]


  #root_domain_zone_id    = "${data.terraform_remote_state.core.project_subdomain_zone_id}"

  root_block_device {
    delete_on_termination = true
    volume_size           = "${var.volume_size}"
    volume_type           = "gp2"
  }
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_iam_role_policy" "bastion_role_policy" {
  name = "bastion_role_policy"
  role = "${aws_iam_role.bastion_role.id}"

  policy = <<EOF
{
    "Statement": [
        {
            "Effect": "Deny",
            "Action": [
                "*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role" "bastion_role" {
  name = "putProject_and_Environment_here_bastion_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "bastion_instance_profile" {
  name  = "putProject_and_Environment_here_bastion_instance_profile"
  roles = ["${aws_iam_role.bastion_role.name}"]
}
