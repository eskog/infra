variable "k8s_worker_cpu_cores" {
    default = 4
}
variable "k8s_worker_memory" {
    default = 4096
}


variable "k8s_worker_nodes" {
  type = map(object({
    hostname     = string
    vmid     = number
  }))
  default = {
    "worker01" = {
      hostname     = "worker01"
      vmid = 1101
    }
    "worker02" = {
      hostname     = "worker02"
      vmid = 1102
    }
    "worker03" = {
      hostname     = "master03"
      vmid = 1103
    }
    "worker04" = {
      hostname     = "master04"
      vmid = 1104
    }
    "worker05" = {
      hostname     = "master05"
      vmid = 1105
    }
    "worker06" = {
      hostname     = "master06"
      vmid = 1106
    }
  }
}