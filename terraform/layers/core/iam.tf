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

resource "aws_iam_role" "s3_access" {
  name = "putProject_and_Environment_here-s3_access"

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

#This instance profile is sufficient for bootstrapping and accessing S3
resource "aws_iam_instance_profile" "bootstraping_Ec2_profile" {
  name  = "putProject_and_Environment_here-bootstrap"
  roles = ["${aws_iam_role.bootstraping_Ec2.name}"]
}
