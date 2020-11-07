resource "kubernetes_service" "rust_server" {
  metadata {
    name      = var.name
    namespace = kubernetes_namespace.rust_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  spec {
    type = "NodePort"
    selector = {
      "app.kubernetes.io/name" = var.name
    }
    port {
      name        = "server"
      protocol    = "TCP"
      port        = var.rust_server_port
      target_port = var.rust_server_port
    }
    port {
      name        = "server"
      protocol    = "UDP"
      port        = var.rust_server_port
      target_port = var.rust_server_port
    }
    port {
      name        = "rcon"
      protocol    = "TCP"
      port        = var.rust_rcon_port
      target_port = var.rust_rcon_port
    }
    port {
      name        = "app"
      protocol    = "TCP"
      port        = var.rust_app_port
      target_port = var.rust_app_port
    }
  }
}