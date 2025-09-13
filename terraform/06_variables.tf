variable "k8s_master_cpu_cores" {
    default = 8
    description = "CPU Core count"
}
variable "k8s_master_memory" {
    default = 8192
    description = "RAM"
}


variable "k8s_master_nodes" {
  type = map(object({
    hostname     = string
    vmid     = number
  }))
  default = {
    "k1-m1" = {
      hostname     = "k1-m1"
      vmid = 1001
    }
    "k1-m2" = {
      hostname     = "k1-m2"
      vmid = 1002
    }
    "k1-m3" = {
      hostname     = "k1-m3"
      vmid = 1003
    }
  }
}