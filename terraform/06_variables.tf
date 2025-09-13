variable "k8s_master_cpu_cores" {
    default = 8
    description = "CPU Core count"
    type = number
}
variable "k8s_master_memory" {
    default = 8192
    description = "RAM"
    type = number
}


variable "k8s_master_nodes" {
  type = map(object({
    hostname     = string
    vmid     = number
  }))
  description = "Definition of the master nodes"
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