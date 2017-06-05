module "app" {
  source = "../../modules/apache-app"

  environment_name = "${var.environment_name}"
  network_state    = "${var.network_state}"
  region           = "${var.region}"
  project          = "${var.project}"
  key_name         = "${var.key_name}"
}
