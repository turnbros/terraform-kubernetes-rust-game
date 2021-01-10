resource "kubernetes_service" "rust_server_tcp_services" {
  metadata {
    name      = "${var.name}-tcp"
    namespace = kubernetes_namespace.rust_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "${var.name}-tcp"
    }, local.labels)
    annotations = {
      "kubernetes.digitalocean.com/load-balancer-id" : "c05affd9-a619-476b-a0c6-d80e7a4c1bac"
    }
  }
  spec {
    type = "LoadBalancer"
    selector = {
      "app.kubernetes.io/name" = var.name
    }
    port {
      name        = "server-tcp"
      protocol    = "TCP"
      port        = var.rust_server_port
      target_port = var.rust_server_port
    }
    port {
      name        = "steam-tcp"
      protocol    = "TCP"
      port        = 27015
      target_port = 27015
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