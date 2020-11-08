resource "kubernetes_service" "rust_server" {
  metadata {
    name      = var.name
    namespace = kubernetes_namespace.rust_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
    annotations = {
      "external-dns.alpha.kubernetes.io/hostname" : "${var.name}.${var.domain_name}"
    }
  }
  spec {
    type = "NodePort"
    selector = {
      "app.kubernetes.io/name" = var.name
    }
    port {
      name        = "server-tcp"
      protocol    = "TCP"
      port        = var.rust_server_port
      target_port = var.rust_server_port
      node_port   = var.rust_server_port
    }
    port {
      name        = "server-udp"
      protocol    = "UDP"
      port        = var.rust_server_port
      target_port = var.rust_server_port
      node_port   = var.rust_server_port
    }
    port {
      name        = "rcon"
      protocol    = "TCP"
      port        = var.rust_rcon_port
      target_port = var.rust_rcon_port
      node_port   = var.rust_rcon_port
    }
    # TODO: This should be a TLS terminated ingress route
    port {
      name        = "rcon-app"
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
      node_port   = var.rust_rcon_app_port
    }
    port {
      name        = "app"
      protocol    = "TCP"
      port        = var.rust_app_port
      target_port = var.rust_app_port
      node_port   = var.rust_app_port
    }
  }
}