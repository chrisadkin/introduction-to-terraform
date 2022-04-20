# Objectives

- Demonstrate the use of variables with Terraform configurations.
- Demonstrate the use of Terraform workspaces

# Instructions

1. Execute the following command from the `tutorial-02` directory
```
terraform init 
```

2. Execute the following command from the `tutorial-02` directory
```
terraform apply --auto-approve 
```

3. Look at the namespaces present in your Kubernetes cluster:
```
kubectl get ns 
```

4. Open the terraform.tfvars file in the text editor of your choice and change "tutorial-02" to something else:
```
namespace = "tutorial-02"
```

Note:

- 
