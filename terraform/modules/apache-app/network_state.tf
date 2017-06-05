data "terraform_remote_state" "network" {
  backend = "s3"

  config {
    bucket = "${var.network_state["bucket"]}"
    key    = "${var.network_state["key"]}"
    region = "${var.network_state["region"]}"
  }
}
