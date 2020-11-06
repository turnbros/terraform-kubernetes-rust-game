resource "random_pet" "instance_name" {}
locals {
  instance_id = random_pet.instance_name.id
  labels = {
    "app.kubernetes.io/instance" = local.instance_id
  }
}