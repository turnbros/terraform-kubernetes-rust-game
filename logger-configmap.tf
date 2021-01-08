resource "kubernetes_config_map" "wireguard_config" {
  metadata {
    name      = "${local.logger_name}-wireguard"
    namespace = kubernetes_namespace.rust_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  data = {
    "wireguard.conf" = templatefile("${path.module}/templates/wireguard-config-file.tmpl", {
      wireguard_listen_port            = var.wireguard_listen_port
      wireguard_private_key            = var.wireguard_private_key
      wireguard_remote_peer_public_key = var.wireguard_remote_peer_public_key
      wireguard_allowed_ip_cidrs       = jsonencode(var.wireguard_allowed_ip_cidrs)
      wireguard_remote_endpoint_ip     = var.wireguard_remote_endpoint_ip
      wireguard_remote_endpoint_port   = var.wireguard_remote_endpoint_port
    })
  }
}

resource "kubernetes_config_map" "filebeat_config" {
  metadata {
    name      = "${local.logger_name}-filebeat"
    namespace = kubernetes_namespace.rust_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  data = {
    "filebeat.yml" = yamlencode({
      "filebeat.inputs" = [{
        type    = "log"
        enabled = true
        paths = [
          "${local.log_path}/*.log"
        ]
      }]
      "output.elasticsearch" = {
        hosts = [
          "${var.elasticsearch_endpoint_hostname}:${var.elasticsearch_endpoint_port}"
        ]
        username = var.elasticsearch_endpoint_username
        password = var.elasticsearch_endpoint_password
      }
    })
  }
}