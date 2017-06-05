data "template_file" "cloud_init_app" {
  template = "${data.template_cloudinit_config.app.rendered}"
}

# Multi-part cloudinit config:
data "template_cloudinit_config" "app" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = "${file("${path.module}/cloudinit/cloud-init-config-template.yaml")}"
  }

  part {
    filename     = "shellscript-10-install-apache.sh"
    content_type = "text/x-shellscript"
    content      = "${file("${path.module}/cloudinit/install-apache.sh")}"
  }
}
