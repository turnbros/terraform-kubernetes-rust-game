resource "kubernetes_deployment" "rust_deployment" {
  metadata {
    name      = var.name
    namespace = kubernetes_namespace.rust_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  spec {
    selector {
      match_labels = {
        "app.kubernetes.io/name" = local.logger_name
      }
    }
    template {
      metadata {
        labels = merge({
          "app.kubernetes.io/name" : local.logger_name
        }, local.labels)
      }
      spec {
        image_pull_secrets {
          name = kubernetes_secret.secret.metadata.0.name
        }
        automount_service_account_token = false
        container {
          name              = local.logger_name
          image             = "${var.logger_image_repository}/${var.logger_image_name}:${var.logger_image_tag}"
          image_pull_policy = var.image_pull_policy
          # This is a temp value.
          args = ["ip", "route", "add", "192.168.1.0/24", "via", "0.0.0.0", "dev", var.wireguard_interface_name, "&&" , "sleep", "18000"]

          env {
            name  = "INTERFACE_NAME"
            value = var.wireguard_interface_name
          }
          env {
            name  = "WIREGUARD_IP"
            value = var.wireguard_ip_address
          }
          env {
            name  = "WIREGUARD_KEY_PATH"
            value = "/opt/wireguard-key/private.key"
          }
          env {
            name  = "WIREGUARD_CONFIG_PATH"
            value = "/opt/wireguard-config/wireguard.conf"
          }

          volume_mount {
            name       = "wireguard-key"
            mount_path = "/opt/wireguard-key"
            read_only  = true
          }
          volume_mount {
            name       = "wireguard-config"
            mount_path = "/opt/wireguard-config"
            read_only  = true
          }
          volume_mount {
            name       = "filebeat-config"
            mount_path = "/opt/filebeat"
            read_only  = true
          }
          volume_mount {
            mount_path = local.log_path
            name       = "log-data"
            read_only  = true
          }

          security_context {
            capabilities {
              add = ["NET_ADMIN"]
            }
          }

          # TODO: Enable resource limits (Once we understand what the requirements are)
          #resources {
          #  requests {
          #    cpu    = var.cpu_request
          #    memory = var.memory_request
          #  }
          #  limits {
          #    cpu    = var.cpu_limit
          #    memory = var.memory_limit
          #  }
          #}

        }
        container {
          name              = var.name
          image             = "${var.image_repository}/${var.image_name}:${var.image_tag}"
          image_pull_policy = var.image_pull_policy

          env {
            name  = "DEPLOYMENT_ID"
            value = "${var.name}-${local.instance_id}"
          }
          env {
            name  = "BUCKET_ACCESS_KEY"
            value = var.bucket_access_key
          }
          env {
            name  = "BUCKET_SECRET_KEY"
            value = var.bucket_secret_key
          }
          env {
            name  = "BUCKET_HOST"
            value = var.bucket_host
          }
          env {
            name  = "BUCKET_NAME"
            value = var.bucket_name
          }
          env {
            name  = "BUCKET_SERVER_DATA_PREFIX"
            value = var.bucket_server_data_prefix
          }
          env {
            name  = "RUST_SERVER_STARTUP_ARGUMENTS"
            value = "${var.rust_server_startup_arguments} -logfile ${local.log_path}/${var.name}.log"
          }
          env {
            name  = "RUST_SERVER_IDENTITY"
            value = var.rust_server_identity
          }
          env {
            name  = "RUST_SERVER_PORT"
            value = var.rust_server_port
          }
          env {
            name  = "RUST_SERVER_SEED"
            value = local.rust_server_seed
          }
          env {
            name  = "RUST_SERVER_WORLDSIZE"
            value = var.rust_server_worldsize
          }
          env {
            name  = "RUST_SERVER_NAME"
            value = var.rust_server_name
          }
          env {
            name  = "RUST_SERVER_MAXPLAYERS"
            value = var.rust_server_maxplayers
          }
          env {
            name  = "RUST_SERVER_DESCRIPTION"
            value = var.rust_server_description
          }
          env {
            name  = "RUST_SERVER_URL"
            value = var.rust_server_url
          }
          env {
            name  = "RUST_SERVER_BANNER_URL"
            value = var.rust_server_banner_url
          }
          env {
            name  = "RUST_SERVER_SAVE_INTERVAL"
            value = var.rust_server_save_interval
          }
          env {
            name  = "RUST_RCON_WEB"
            value = var.rust_rcon_web
          }
          env {
            name  = "RUST_RCON_PORT"
            value = var.rust_rcon_port
          }
          env {
            name  = "RUST_RCON_PASSWORD"
            value = var.rust_rcon_password
          }
          env {
            name  = "RUST_APP_PORT"
            value = var.rust_app_port
          }
          env {
            name  = "RUST_BRANCH"
            value = var.rust_branch
          }
          env {
            name  = "RUST_UPDATE_CHECKING"
            value = var.rust_update_checking
          }
          env {
            name  = "RUST_UPDATE_BRANCH"
            value = var.rust_update_branch
          }
          env {
            name  = "RUST_START_MODE"
            value = var.rust_start_mode
          }
          env {
            name  = "RUST_OXIDE_ENABLED"
            value = var.rust_oxide_enabled
          }
          env {
            name  = "RUST_OXIDE_UPDATE_ON_BOOT"
            value = var.rust_oxide_update_on_boot
          }

          port {
            name           = "server-port"
            container_port = var.rust_server_port
          }

          port {
            name           = "rcon-port"
            container_port = var.rust_rcon_port
          }
          port {
            name           = "app-port"
            container_port = var.rust_app_port
          }

          resources {
            requests {
              cpu    = var.cpu_request
              memory = var.memory_request
            }
            limits {
              cpu    = var.cpu_limit
              memory = var.memory_limit
            }
          }

          #liveness_probe {
          #  initial_delay_seconds = 600
          #  tcp_socket {
          #    port = var.rust_rcon_port
          #  }
          #}
          #
          #readiness_probe {
          #  initial_delay_seconds = 600
          #  tcp_socket {
          #    port = var.rust_rcon_port
          #  }
          #}

          volume_mount {
            mount_path = local.log_path
            name       = "log-data"
          }
        }
        volume {
          name = "wireguard-key"
          secret {
            secret_name = kubernetes_secret.wireguard_private_key.metadata.0.name
          }
        }
        volume {
          name = "wireguard-config"
          config_map {
            name = kubernetes_config_map.wireguard_config.metadata.0.name
          }
        }
        volume {
          name = "filebeat-config"
          config_map {
            name = kubernetes_config_map.filebeat_config.metadata.0.name
          }
        }
        volume {
          name = "log-data"
          empty_dir {}
        }
      }
    }
  }
}