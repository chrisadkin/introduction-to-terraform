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
