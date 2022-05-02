variable "pvcs" {
  type = map(object({
      name = string
      size = string
    }))
  default = {
    test = {
      name = "test2-pvc"
      size = "2Gi"
    },
    dev = {
      name = "dev-pvc"
      size = "1Gi" 
    }
  }
}
