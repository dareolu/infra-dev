module "cm-manager" {
  source = "./modules/cm-manager"

  #manager              = "${var.manager}"
  #tags                 = "${var.tags}"
  #ami_id               = "${var.ami["trusty"]}"
  #private_subnet_id    = "${lookup(null_resource.subnet_ids.triggers, var.cloudera_availability_zone)}"
  #environment          = "${var.environment}"
  #layer                = "${var.layer}"
  #vpc_id               = "${data.terraform_remote_state.core.vpc_id}"
  #access_from          = ["${data.terraform_remote_state.core.vpc_cidr_block}", "${var.vpc_peering_cidr}"]
  #iam_instance_profile = "${data.terraform_remote_state.core.ec2_bootstrap_profile_name}"
  #key_name             = "${var.key_name}"
  #ssh_access_from      = ["${data.terraform_remote_state.support.bastion_private_ip_cidr}"]
  #availability_zone    = "${var.cloudera_availability_zone}"
  #security_group_ids   = ["${aws_security_group.cm-default.id}"]
}
