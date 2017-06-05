# Define the VPC:
resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_network}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name        = "${var.region}.geekshubs.${var.environment_name}"
  }
}

# And an Internet-Gateway:
resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "igw.${var.region}.${var.environment_name}"
  }
}

# Outputs:
output "aws_vpc.main" {
  value = {
    id         = "${aws_vpc.main.id}"
    cidr_block = "${aws_vpc.main.cidr_block}"
  }
}
