resource "aws_elb" "app" {
  name    = "app-${var.project}-${var.environment_name}"
  subnets = ["${data.terraform_remote_state.network.public_subnets}"]

  security_groups = ["${aws_security_group.app_elb.id}"]
  internal        = false

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    target              = "TCP:80"
    interval            = 40
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 30
  connection_draining         = true
  connection_draining_timeout = 30

  tags {
    Name = "app-${var.project}-${var.environment_name}"
  }
}
