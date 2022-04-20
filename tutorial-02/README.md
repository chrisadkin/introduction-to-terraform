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

- The variables.tf file is used to define variables, optionally variables can be given default values in this file
- terraform.tfvars specfies non-default variable values
- Unless a variables file is explicitly referred to on the ```terraform apply``` command line, values for variables will always be obtained from
  a terraform.tfvars file if one is present
  
5. By default all state is associated with a specific workspace called default, lets verify this
```
terraform workspace show
```

6. Create a new workspace:
```
terraform workspace new tutorial-02
```

7. Note that a new directory called terraform.tfstate.d has now appeared, change directory into this and also note that it contains a
   subdirectory called tutorial-02.
   
8. Go back to the directory containing the configuration, give the namespace variable in terraform.tfvars a new value that has not been used before.

9. Re-apply the configuration:
```
terraform apply -auto-approve
```

10. Note the namespaces now present in the Kubernetes cluster:
```
kubectl get ns
```

11. Return the Kubernetes cluster back to the state it was in priot to this tutorial:
```
terraform destroy -auto-approve
terraform workspace select default
terraform destroy -auto-approve
```
