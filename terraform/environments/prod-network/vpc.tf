module "vpc" {
  source = "../../modules/vpc-public-private"

  region           = "${var.region}"
  azs              = "${var.azs}"
  environment_name = "${var.environment_name}"
  vpc_network      = "${var.vpc_network}"
  project          = "${var.project}"
  office_ip_cidrs  = "${var.office_ip_cidrs}"
  key_name         = "${var.key_name}"
}

# Outputs (will end up on S3 so subsequent layers can refer to them as "shared state"):
output "vpc_id" {
  value = "${module.vpc.aws_vpc["id"]}"
}

output "vpc_network" {
  value = "${var.vpc_network}"
}

output "azs" {
  value = "${var.azs}"
}

output "public_subnets" {
  value = "${module.vpc.public_subnets}"
}

output "private_subnets" {
  value = "${module.vpc.private_subnets}"
}

output "bastion_sg" {
  value = "${module.vpc.bastion_sg}"
}
