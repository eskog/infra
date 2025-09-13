variable "k8s_worker_cpu_cores" {
    default = 12
    description = "CPU Core count"
    type = number
}
variable "k8s_worker_memory" {
    default = 12288
    description = "RAM"
    type = number
}


variable "k8s_worker_nodes" {
  type = map(object({
    hostname     = string
    vmid     = number
  }))
  description = "Definition of the worker nodes"
  default = {
    "k1-w1" = {
      hostname     = "k1-w1"
      vmid = 1101
    }
    "k1-w2" = {
      hostname     = "k1-w2"
      vmid = 1102
    }
    "k1-w3" = {
      hostname     = "k1-w3"
      vmid = 1103
    }
    "k1-w4" = {
      hostname     = "k1-w4"
      vmid = 1104
    }
    "k1-w5" = {
      hostname     = "k1-w5"
      vmid = 1105
    }
    "k1-w6" = {
      hostname     = "k1-w6"
      vmid = 1106
    }
    "k1-w7" = {
      hostname     = "k1-w7"
      vmid = 1107
    }
    "k1-w8" = {
      hostname     = "k1-w8"
      vmid = 1108
    }
    "k1-w9" = {
      hostname     = "k1-w9"
      vmid = 1109
    }
    
  }
}