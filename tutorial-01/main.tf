provider "kubernetes" {
  config_path    = "~/.kube/config"
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "tutorial-01"
  }
}
