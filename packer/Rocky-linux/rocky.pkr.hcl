packer {
  required_plugins {
    name = {
      version = "1.2.3"
      source = "github.com/hashicorp/proxmox"
    }
  }
}

variable "TOKEN_ID" {
  type    = string
  sensitive = true
}
variable "TOKEN_SECRET" {
  type = string
  sensitive = true
}
variable "proxmox_url" {
  type = string
}

source "proxmox-iso" "rocky" {
  boot_command = [
  "<up><wait>",
  "e<wait>",
  "<down><down><end>",
  " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg inst.text",
  "<f10>"
]
  boot_wait    = "10s"
  disks {
    disk_size         = "35G"
    storage_pool      = "local-lvm"
    type              = "virtio" #or scsi
    format            = "raw" #Cant be qcow on local-lvm.
  }
  efi_config {
    efi_storage_pool  = "local-lvm"
    efi_type          = "4m"
    pre_enrolled_keys = true
  }
  http_directory           = "http"
  insecure_skip_tls_verify = true
  boot_iso {
    iso_url           = "https://download.rockylinux.org/pub/rocky/10/isos/x86_64/Rocky-10.1-x86_64-minimal.iso"
    iso_checksum      = "sha256:5aafc2c86e606428cd7c5802b0d28c220f34c181a57eefff2cc6f65214714499"
    iso_storage_pool  = "local"  # or your appropriate pool
    type              = "sata"
  }
  network_adapters {
    bridge = "stageing"
    model  = "virtio"
  }
  node                 = "pve01"
  token                = var.TOKEN_SECRET
  proxmox_url          = var.proxmox_url

  ssh_password         = "changeme"
  ssh_timeout          = "10m"
  ssh_username         = "admin"
  
  template_description = "Rocky 10, generated on ${timestamp()}"
  template_name        = "rocky-10"
  
  username             = "${var.TOKEN_ID}"
  
  vm_id                = 9000
  memory               = 2048
  cores                = 2
  sockets              = 1
  cpu_type             = "host"
  scsi_controller      = "virtio-scsi-single"
  os                   = "l26"
  qemu_agent           = true

  cloud_init              = true
  cloud_init_storage_pool = "local-lvm"
}

build {
  sources = ["source.proxmox-iso.rocky"]

      provisioner "shell" {
        inline = [
            "sudo rm /etc/ssh/ssh_host_*",
            "sudo hostnamectl set-hostname localhost",
            "sudo truncate -s 0 /etc/machine-id",
            "sudo rm -f /var/lib/dbus/machine-id",
            "sudo mkdir -p /var/lib/dbus",
            "sudo ln -sf /etc/machine-id /var/lib/dbus/machine-id",
            "sudo rm -f /var/lib/dhclient/*",
            "sudo rm -rf /var/lib/cloud/*",
            "sudo dnf update -y",
            "sudo dnf upgrade -y",
            "sudo dnf clean all",
            "sudo journalctl --rotate",
            "sudo journalctl --vacuum-time=1s",
            "sudo rm -rf /var/log/* /tmp/* /var/tmp/*",
            "sudo rm -rf /var/cache/dnf",
            "sudo sync",
            "sudo usermod -L -e 1 admin",
            "history -c"
        ]
    }
}
