resource "aws_instance" "bastion" {
  ami                         = "${var.images["ubuntu16"]}"
  availability_zone           = "${element(var.azs, 0)}"
  instance_type               = "${var.bastion_instance_type}"
  key_name                    = "${var.key_name}"
  monitoring                  = true
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]
  subnet_id                   = "${element(aws_subnet.public.*.id, 0)}"
  associate_public_ip_address = true

  tags {
    Name        = "bastion-${var.project}-${var.environment_name}"
    Environment = "${var.environment_name}"
  }
}
