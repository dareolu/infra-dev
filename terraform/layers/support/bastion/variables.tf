variable "state_bucket" {}
variable "state_file" {}
variable "key_name" {}
variable "availability_zone" {}
variable "instance_type" {}
variable "aws_profile" {}
variable "volume_size" {}
variable "ami_id" {}
variable "instance_count" {}

variable "public_key_path" {}

variable "region" {
  default = "eu-west-1"
}
