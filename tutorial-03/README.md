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

4. Open the main.tf file in the text editor of your choice:






## Destroy

Execute the following command from the `tutorial-03` directory
```
terraform destroy --auto-approve 
```
