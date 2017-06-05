resource "aws_subnet" "private" {
  count = "${length(var.azs)}"

  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(null_resource.network_layer_cidrs.triggers.app, 2, count.index)}"
  availability_zone = "${element(var.azs, count.index)}"

  tags {
    Name        = "${var.project}-Private-${count.index}"
    Environment = "${var.environment_name}"
  }
}

resource "aws_route_table" "private" {
  count = "${length(var.azs)}"

  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${var.project}-PrivateRouteTable-${count.index}"
    Environment = "${var.environment_name}"
  }
}

resource "aws_route" "private" {
  count = "${length(var.azs)}"

  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.nats.*.id, count.index)}"
}

resource "aws_route_table_association" "private" {
  count = "${length(var.azs)}"

  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

output "private_subnets" {
  value = ["${aws_subnet.private.*.id}"]
}
