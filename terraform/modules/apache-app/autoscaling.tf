# Define a launch-config for this role:
resource "aws_launch_configuration" "app" {
  name_prefix                 = "app-${var.environment_name}-"
  image_id                    = "${var.images["ubuntu16"]}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${aws_iam_instance_profile.app.id}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.app.id}"]
  enable_monitoring           = false
  associate_public_ip_address = false
  user_data                   = "${data.template_file.cloud_init_app.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

# Define an autoscaling-group:
resource "aws_autoscaling_group" "app" {
  availability_zones        = ["${data.terraform_remote_state.network.azs}"]
  name                      = "app-${var.environment_name}"
  max_size                  = "${var.asg["max_size"]}"
  min_size                  = "${var.asg["min_size"]}"
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = "${var.asg["desired_capacity"]}"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.app.name}"
  vpc_zone_identifier       = ["${data.terraform_remote_state.network.private_subnets}"]
  load_balancers            = ["${aws_elb.app.name}"]

  tag {
    key                 = "environment"
    value               = "${var.environment_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "app-${var.project}-${var.environment_name}"
    propagate_at_launch = true
  }
}
