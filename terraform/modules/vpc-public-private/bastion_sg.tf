# Define a security group for this specific role:
resource "aws_security_group" "bastion" {
  name        = "bastion-${var.project}-${var.environment_name}"
  description = "For bastion ${var.project} ${var.environment_name} instances"
  vpc_id      = "${aws_vpc.main.id}"

  tags {
    Name        = "bastion-${var.project}-${var.environment_name}"
    environment = "${var.environment_name}"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.office_ip_cidrs}"]
  }

  ingress {
    from_port   = "-1"
    to_port     = "-1"
    protocol    = "icmp"
    cidr_blocks = ["${var.vpc_network}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "bastion_sg" {
  value = ["${aws_security_group.bastion.id}"]
}
