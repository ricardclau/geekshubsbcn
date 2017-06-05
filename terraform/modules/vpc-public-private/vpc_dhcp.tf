# DHCP options:
resource "aws_vpc_dhcp_options" "main" {
  domain_name         = "${var.region}.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags {
    Name        = "dhcp-${var.project}-${var.environment_name}"
    Environment = "${var.environment_name}"
  }
}

# Associate DHCP options to the VPC:
resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = "${aws_vpc.main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.main.id}"
}
