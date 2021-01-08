resource "random_pet" "instance_name" {}
resource "random_integer" "rust_server_seed" {
  min = 10000
  max = 99999
}
locals {
  logger_name      = "${var.name}-logger"
  log_path         = "/var/log/rust_server"
  instance_id      = random_pet.instance_name.id
  rust_server_seed = var.rust_server_seed == null ? random_integer.rust_server_seed.result : var.rust_server_seed
  labels = {
    "app.kubernetes.io/instance" = local.instance_id
  }
}