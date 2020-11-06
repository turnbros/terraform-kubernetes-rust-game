resource kubernetes_deployment "rust_deployment" {
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
        "app.kubernetes.io/name" = var.name
      }
    }
    template {
      metadata {
        labels = merge({
          "app.kubernetes.io/name" : var.name
        }, local.labels)
      }
      spec {
        automount_service_account_token = false
        container {
          name              = var.name
          image             = "${var.image_repository}/${var.image_name}:${var.image_tag}"
          image_pull_policy = var.image_pull_policy

          env {
            name  = "RUST_SERVER_STARTUP_ARGUMENTS"
            value = var.rust_server_startup_arguments
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
            value = var.rust_server_seed
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

          liveness_probe {
            initial_delay_seconds = 600
            tcp_socket {
              port = var.rust_rcon_port
            }
          }

          readiness_probe {
            initial_delay_seconds = 600
            tcp_socket {
              port = var.rust_rcon_port
            }
          }
        }
      }
    }
  }
}