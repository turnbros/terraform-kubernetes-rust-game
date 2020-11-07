resource "kubernetes_secret" "secret" {
  metadata {
    name      = "regcred"
    namespace = kubernetes_namespace.rust_namespace.metadata.0.name
  }
  data = {
    ".dockerconfigjson" : base64decode(var.image_pull_secret)
  }
  type = "kubernetes.io/dockerconfigjson"
}