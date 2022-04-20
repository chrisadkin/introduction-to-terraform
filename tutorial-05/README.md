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
terraform apply --auto-approve 
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
resource "local_file" "kubespray_inventory" {
  content = templatefile("templates/kubespray_inventory.tpl", {
    k8s_node_host_verbose_etcd = replace(join("\", \"\n", local.all_nodes_verbose_etcd), "\", \"", "") 
    k8s_node_host_verbose      = replace(join("\", \"\n", local.all_nodes_verbose), "\", \"", "") 
    k8s_master_host            = replace(join("\", \"\n", local.master_nodes), "\", \"", "") 
    k8s_etcd_host              = replace(join("\", \"\n", local.etcd_nodes), "\", \"", "") 
    k8s_node_host              = replace(join("\", \"\n", local.all_nodes), "\", \"", "") 
  })
  filename = "./inventory.ini"
}
```

  - The templatefile function requires a template, this is the kubespray_inventory.tpl file in the templates folder:

```
[all]
${k8s_node_host_verbose_etcd}
${k8s_node_host_verbose}

[kube-master]
${k8s_master_host}

[etcd]
${k8s_etcd_host}

[kube-node]
${k8s_node_host}

[calico-rr]

[k8s-cluster:children]
kube-master
kube-node
calico-rr
```

  - The templatefile function takes the locals variables, maps them to the ${ } placeholders in the template (.tpl) file and produces an 
    inventory.ini file. 
    
5. Open the resulting inventory.ini files using a text editor of your choice, compare its contents to the values in the node_hosts variable in
   the variables.tf file for the ```arc``` map.
   
6. 
