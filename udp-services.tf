resource "kubernetes_service" "rust_server_udp_services" {
  metadata {
    name      = "${var.name}-udp"
    namespace = kubernetes_namespace.rust_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "${var.name}-udp"
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
      name        = "server-udp"
      protocol    = "UDP"
      port        = var.rust_server_port
      target_port = var.rust_server_port
    }
    port {
      name        = "steam-udp"
      protocol    = "UDP"
      port        = 27015
      target_port = 27015
    }
  }
}