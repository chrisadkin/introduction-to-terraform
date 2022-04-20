# Objectives

- Demonstrate the use of a third party Terraform plugin via a simple configuration to create a Kubernetes PVC
- Demonstrate Hashicorp Control Language interpolation.

# Instructions

1. Execute the following command from the `tutorial-03` directory
```
terraform apply --auto-approve 
```

2. The tutorials so far have used first party providers authored by Hashicorp. Terraform is designed to be extensible and allows third parties
   to create providers, in this instance a provider that facilitates the use of a kubernetes_manifest provider will be used. Issue the folling command:
```
terraform init 
```

3. List the providers associated with this configuration and note the new none Hashicorp authored provider:
```
terraform providers 
```

4. Open the main.tf file in the text editor of your choice and note the kubectl_manifest resource, in particular note the text enclosed with ${ },
   when the configuration is applied, Terraform will use what is known as 'Interpolation' to substitute ```{var.pvc_size}``` and ```{var.storage_class}```
   with the values of ```pvc_size``` and ```storage_class``` from the terraform.tfvars file:
```
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
```

Note

Interpolation, the ability to insert text into larger bodies of text is one of the most powerful feature of Hashicorp Control Language

5. Apply the configuration:
```
terraform apply -auto-approve
```

6. Verify that the test-pvc persistent volume claim has been created:
```
kubectl get pvc
```

7. Return the Kubernetes cluster to the state it was in at the start of this tutorial:
```
terraform destroy --auto-approve 
```
