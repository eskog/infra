terraform {
  required_version = ">= 0.13.0"

  required_providers {
    proxmox = {
      # LINK https://github.com/Telmate/terraform-provider-proxmox
      source = "telmate/proxmox"
      version = "3.0.2-rc07"
    }
  }
}

variable "PROXMOX_URL" {
  type = string
  description = "URL of the proxmox node"
}

variable "PROXMOX_USER" {
  type      = string
  sensitive = true
  description = "username for proxmox"
}

variable "PROXMOX_TOKEN" {
  type      = string
  sensitive = true
  description = "API token of user"
}

variable "PUBLIC_SSH_KEY" {
  # NOTE This is the public SSH key, you want to upload to VMs and LXC containers.
  type      = string
  sensitive = true
  default = "~/.ssh/skog.network.pub"
  description = "ssh key for VMs"
}

variable "pvenode" {
    type = string
    description = "Target node for the creation of VMs"
}

provider "proxmox" {
  pm_api_url = var.PROXMOX_URL
  pm_api_token_id = var.PROXMOX_USER
  pm_api_token_secret = var.PROXMOX_TOKEN
  
  # NOTE Optional, but recommended to set to true if you are using self-signed certificates.
  pm_tls_insecure = true
}