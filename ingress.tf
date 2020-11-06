locals {

  rcon_tcp_ingress = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "IngressRouteTCP"
    metadata = {
      name = "${var.name}-rcon-tcp"
    }
    spec = {
      entryPoints = [
        # TODO: This
        "footcp"
      ]
      routes = [
        {
          match = "HostSNI(`*`)"
          services = [
            {
              name             = kubernetes_service.rust_server.metadata.0.name
              port             = var.rust_rcon_port
              weight           = 10
              terminationDelay = 400
            }
          ]
        }
      ]
    }
  }

  app_tcp_ingress = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "IngressRouteTCP"
    metadata = {
      name = "${var.name}-app-tcp"
    }
    spec = {
      entryPoints = [
        # TODO: This
        "footcp"
      ]
      routes = [
        {
          match = "HostSNI(`*`)"
          services = [
            {
              name             = kubernetes_service.rust_server.metadata.0.name
              port             = var.rust_app_port
              weight           = 10
              terminationDelay = 400
            }
          ]
        }
      ]
    }
  }

  server_tcp_ingress = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "IngressRouteTCP"
    metadata = {
      name = "${var.name}-server-tcp"
    }
    spec = {
      entryPoints = [
        # TODO: This
        "footcp"
      ]
      routes = [
        {
          match = "HostSNI(`*`)"
          services = [
            {
              name             = kubernetes_service.rust_server.metadata.0.name
              port             = var.rust_server_port
              weight           = 10
              terminationDelay = 400
            }
          ]
        }
      ]
    }
  }

  server_udp_ingress = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "IngressRouteUDP"
    metadata = {
      name = "${var.name}-server-udp"
    }
    spec = {
      entryPoints = [
        # TODO: This
        "fooudp"
      ]
      routes = [
        {
          services = {
            name   = kubernetes_service.rust_server.metadata.0.name
            port   = var.rust_server_port
            weight = 10
          }
        }
      ]
    }
  }
}