# Overview

This module:
- Creates an Azure Arc managed SQL Server instance

# Usage

## Apply

Execute the following command from the `Arc-PX-VMware-Faststart/azure_data_services` directory
```
terraform apply -target=module.arc_sql_mi --auto-approve 
```

## Destroy

Execute the following command from the `Arc-PX-VMware-Faststart/azure_data_services` directory
```
terraform destroy -target=module.arc_sql_mi --auto-approve 
```

# Dependencies

- Context in .kube/config file of the home directory of the current user with which kubectl can connect to a kubernetes cluster
- Storage class present on the kubernetes cluster deployment target
- An Azure Arc enabled Data Services controller deployed to the same Kubernetes cluster that the managed instance is to be deployed to 
- The username and password variables for the secret must be base64 encoded, i.e.:
```
echo -n <username> | base64
echo -n <password> | base64 
```
  Note: **when the credentials stored in the secret are used to connect to an instance, they must be used in their base64 encoded form** 

# Variables

The minimum set of variables that need to be configured consists of those with no default values.

| Name                        | Data type | Description / Notes                                                 | Mandatory (Y/N) | Default Value                   |
|-----------------------------|-----------|---------------------------------------------------------------------|-----------------|---------------------------------|
| secret_username             | string    | Managed instance username (needs to be base64 encoded)              |        Y        | c2E=         (sa)               | 
| secret_password             | string    | Managed instance password (needs to be base64 encoded)              |        Y        | UEBzc3cwcmQ= (P@ssw0rd)         |
| namespace                   | string    | Kubernetes namespace to deploy managed instance to                  |        Y        | arc-ds                          |
| instance_name               | string    | Azure Arc managed SQL Server instance name                          |        Y        | sqlmi1                          |
| cpu_request                 | integer   | Logical processors requested                                        |        Y        | 4                               |
| cpu_limit                   | integer   | Logical processors limit                                            |        Y        | 4                               |
| memory_request              | string    | Initial instance memory request                                     |        Y        | 2Gi                             |
| memory_limit                | string    | Instance memory limit                                               |        Y        | 4Gi                             |
| service_type                | string    | Service type for instance TDC endpoint, NodePort or LoadBalancer    |        Y        | NodePort                        |
| backups_storage_class       | string    | Storage class for managed backups                                   |        Y        | portworx-sc                     |
| volume_size_backups         | string    | Initial size for managed backup area                                |        Y        | 5Gi                             |
| data_storage_class          | string    | Storage class for .mdf and .ndf files                               |        Y        | portworx-sc                     |       
| volume_size_data            | string    | Initial size for persistent volume to hold .mdf and .ndf files      |        Y        | 5Gi                             |
| data_logs_storage_class     | string    | Storage class for transaction log files                             |        Y        | portworx-sc                     |
| volume_size_data_logs       | string    | Initial size for persistent volume to hold transaction files        |        Y        | 5Gi                             |
| logs_storage_class          | string    | Storage class for /var/logs                                         |        Y        | portworx-sc                     |
| volume_size_logs            | string    | Initial size of the volume that holds /var/logs                     |        Y        | 5Gi                             |
