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
  for_each = var.pvcs
    wait = true
    yaml_body = <<YAML
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: ${each.value["name"]} 
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: ${each.value["size"]}
  storageClassName: standard 
YAML
}
