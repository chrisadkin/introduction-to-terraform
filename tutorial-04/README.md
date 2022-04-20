# Objectives

- Demonstrate the use a variable using a complex datatype; a map
- Demonstrate the use of iteration within a resource to create multiple entities of a resource type

# Instructions

1. Install the plugins for the providers that the configuration uses:
```
terraform init
```

2. Open the main.tf file using the text editor of your choice, note that this looks very similar to the the file used in the last tutorial, but with one
   key difference - ```for_each = var.pvcs```:

```   
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
```

    The ```for_each = var.pvcs``` clause will cause Terraform to create a persistent volume for each member of the map in the variables.tf file:

```

```




