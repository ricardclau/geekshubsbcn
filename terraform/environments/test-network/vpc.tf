module "vpc" {
  source = "../../modules/vpc-public-private"

  azs                 = "${var.azs}"
  environment_name    = "${var.environment_name}"
  region              = "${var.region}"
  vpc_network         = "${var.vpc_network}"
}