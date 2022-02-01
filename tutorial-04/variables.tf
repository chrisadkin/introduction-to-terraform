variable "pvcs" {
  type = map(object({
      name = string
      size = string
    }))
  default = {
    test = {
        name = "test-pvc"
        size = "1Gi 
    },
    dev = {
        name = "dev-pvc"
        size = "1Gi 
    }
  }
}
