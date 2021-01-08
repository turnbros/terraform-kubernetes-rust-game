resource "kubernetes_secret" "wireguard_private_key" {
  metadata {
    name      = "${local.logger_name}-wireguard"
    namespace = kubernetes_namespace.rust_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  data = {
    "private.key" = var.wireguard_private_key
  }
}