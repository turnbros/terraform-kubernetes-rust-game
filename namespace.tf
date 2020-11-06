resource "kubernetes_namespace" "rust_namespace" {
  metadata {
    name = var.name
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
}