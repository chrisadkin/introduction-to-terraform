terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "kubernetes" {
  experiments {
    manifest_resource = true
  }

  config_path = "~/.kube/config"
}

resource "kubectl_manifest" "test_pvc" {
  wait = true
  yaml_body = <<YAML
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: test-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: ${var.pvc_size}
  storageClassName: ${var.storage_class}
YAML
}
