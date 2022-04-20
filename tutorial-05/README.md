# Objectives

A configuration to demonstrate the use of a template with a local file resource.

# Instructions

1. Execute the following command from the `tutorial-05` directory
```
terraform init 
```

2. Open the variables.tf file using the text editor of your choice and note the node_hosts variable - a nested list of map objects, under the default 
   block there is a list of map objects associated with 'arc'.
```
variable "node_hosts" {
  type = map(map(object({
      name          = string
      compute_node  = bool
      etcd_instance = string
      ipv4_address  = string
    })))
  default = {
    arc = {
      control1 = {
        name          = "z-ca-arc-control1"
        compute_node  = false
        etcd_instance = "etcd1"
        ipv4_address  = "10.123.456.01"
      },
      control2 =  {
        name          = "z-ca-arc-control2"
        compute_node  = false
        etcd_instance = "etcd2"
        ipv4_address  = "10.123.456.02"
      },
```

3. Create a terraform arc workspace:
```
terraform workspace new arc
```

4. Apply the configuration:
```
terraform destroy --auto-approve 
```
   Note
   
   - the ```locals``` section parses the list of nested maps as key value pairs

```
locals {
   all_nodes_verbose_etcd = [for k, v in var.node_hosts[terraform.workspace]: 
                               format("%s ip=%s etcd_instance=%s", v.name, v.ipv4_address, v.etcd_instance)
                               if length(v.etcd_instance) > 0]

   all_nodes_verbose      = [for k, v in var.node_hosts[terraform.workspace]:
                               format("%s ip=%s", v.name, v.ipv4_address) 
                               if length(v.etcd_instance) == 0] 

   master_nodes           = [for k, v in var.node_hosts[terraform.workspace]:
                               v.name
                               if v.compute_node != true] 

   etcd_nodes             = [for k, v in var.node_hosts[terraform.workspace]:
                               v.name 
                               if length(v.etcd_instance) > 0] 

   all_nodes              = values(var.node_hosts[terraform.workspace])[*].name
}
```
  - The localfile resource creates a file via the templatefile fuction using the locals variables:
```

```

