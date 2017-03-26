# Configuring IAM policies

resource "aws_iam_role" "bootstraping_Ec2" {
  name = "putProject_and_Environment_here-bootstraping-Ec2"
  path = "/"

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

resource "aws_iam_instance_profile" "bootstraping_Ec2_profile" {
  name  = "putProject_and_Environment_here-bootstrap"
  roles = ["${aws_iam_role.bootstraping_Ec2.name}"]
}

resource "aws_iam_policy" "s3_repository_policy" {
  name = "putProject_and_Environment_here-s3-repository-readonly"
  path = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:ListBucketMultipartUploads"
      ],
      "Resource": [
        "arn:aws:s3:::get-project-tags-here-repository",
        "arn:aws:s3:::get-project-and-environment-tags-here-infrastructure"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectAcl",
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl"
      ],
      "Resource": [
        "arn:aws:s3:::get-project-tags-here-repository/*",
        "arn:aws:s3:::get-project-and-environment-tags-here-infrastructure/*"
      ]
    }
  ]
}
EOF
}

output "bootstraping_Ec2_profile" {
  value = "${aws_iam_instance_profile.bootstraping_Ec2_profile.name}"
}

output "subnet_id" {
  value = "${aws_subnet.public_vpc_spot_a.id}"
}

output "vpc_security_group_ids" {
  value = "${aws_security_group.bastion.id}"
}
