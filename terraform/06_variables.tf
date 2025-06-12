variable "k8s_master_cpu_cores" {
    default = 4
}
variable "k8s_master_memory" {
    default = 4096
}


variable "k8s_master_nodes" {
  type = map(object({
    hostname     = string
    vmid     = number
  }))
  default = {
    "master01" = {
      hostname     = "master01"
      vmid = 1001
    }
    "master02" = {
      hostname     = "master02"
      vmid = 1002
    }
    "master03" = {
      hostname     = "master03"
      vmid = 1003
    }
  }
}