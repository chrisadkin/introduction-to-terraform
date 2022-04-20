# Overview

A simple configuration to create a Kubernetes namespace.

# Instructions

1. Execute the following command from the `tutorial-01` directory in order to install the Kubernetes plugin
```
terraform init
```

2. Now issue the following command, this will tell us what the end result of applying the configuration will look like:
```
terraform plan 
```

3. Look at what namespaces already exist in the Kubernetes cluster:
```
kubectl get ns 
```

4. Now, apply the configuration:
```
terraform apply --auto-approve 
```

5. Check the namespaces in the Kubernetes cluster again:
```
kubectl get ns 
```

6. Change the name of the namespace in the main.tf from "my-first-namespace" to something else:
```
resource "kubernetes_namespace" "example" {
  metadata {
    name = "my-first-namespace"
  }
}
```

7. Apply the configuration again:
```
terraform apply --auto-approve 
```

8. Check the namespaces in the Kubernetes cluster again, why is the my-first-namespace namespace no longer present ?
```
kubectl get ns 
```

9. Execute the following command from the `tutorial-01` directory
```
terraform destroy --auto-approve 
```
