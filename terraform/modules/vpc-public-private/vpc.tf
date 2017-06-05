# Define the VPC:
resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_network}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name        = "${var.project}-${var.environment_name}"
    Environment = "${var.environment_name}"
  }
}

# And an Internet-Gateway:
resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "igw-${var.project}-${var.environment_name}"
    Environment = "${var.environment_name}"
  }
}

resource "null_resource" "network_layer_cidrs" {
  triggers = {
    dmz = "${cidrsubnet(var.vpc_network, 6, 0)}"
    app = "${cidrsubnet(var.vpc_network, 6, 1)}"
  }
}

output "network_layer_cidrs" {
  value = {
    dmz = "${null_resource.network_layer_cidrs.triggers.dmz}"
    app = "${null_resource.network_layer_cidrs.triggers.app}"
  }
}

# Outputs:
output "aws_vpc" {
  value = {
    id         = "${aws_vpc.main.id}"
    cidr_block = "${aws_vpc.main.cidr_block}"
  }
}
