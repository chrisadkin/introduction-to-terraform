variable "kubernetes_version" {
  type        = string
  default     = "1.20.1"
}

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
      compute1 = {
        name          = "z-ca-arc-compute1"
        compute_node  = true
        etcd_instance = "etcd3"
        ipv4_address  = "10.123.456.03"
      },
      compute2 = {
        name          = "z-ca-arc-compute2"
        compute_node  = true
        etcd_instance = ""
        ipv4_address  = "10.123.456.04"
      },
      compute3 = {
        name          = "z-ca-arc-compute3"
        compute_node  = true
        etcd_instance = ""
        ipv4_address  = "10.123.456.05"
      }
    },
    bdc = {
      control1 = {
        name          = "z-ca-bdc-control1"
        compute_node  = false
        etcd_instance = "etcd1"
        ipv4_address  = "10.225.113.80"
      },
      control2 =  {
        name          = "z-ca-bdc-control2"
        compute_node  = false
        etcd_instance = "etcd2"
        ipv4_address  = "10.225.113.81"
      },
      compute1 = {
        name          = "z-ca-bdc-compute1"
        compute_node  = true
        etcd_instance = "etcd3"
        ipv4_address  = "10.225.113.82"
      },
      compute2 = {
        name          = "z-ca-bdc-compute2"
        compute_node  = true
        etcd_instance = ""
        ipv4_address  = "10.225.113.83"
      },
      compute3 = {
        name          = "z-ca-bdc-compute3"
        compute_node  = true
        etcd_instance = ""
        ipv4_address  = "10.225.113.84"
      }
    }
  }
}
