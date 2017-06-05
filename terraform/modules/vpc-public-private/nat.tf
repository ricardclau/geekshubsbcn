resource "aws_eip" "nats" {
  count = "${length(var.azs)}"

  vpc = true
}

resource "aws_nat_gateway" "nats" {
  count = "${length(var.azs)}"

  allocation_id = "${element(aws_eip.nats.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  depends_on = ["aws_internet_gateway.main"]
}
