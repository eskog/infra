resource "proxmox_vm_qemu" "devbox" {

  # SECTION General Settings

  name = "Devbox"
  desc = "Devbox"
  agent = 1  # <-- (Optional) Enable QEMU Guest Agent

  # FIXME Before deployment, set the correct target node name
  target_node = var.pvenode

  # FIXME Before deployment, set the desired VM ID (must be unique on the target node)
  vmid = 0

  # !SECTION
  
  # SECTION Template Settings

  # FIXME Before deployment, set the correct template or VM name in the clone field
  #       or set full_clone to false, and remote "clone" to manage existing (imported) VMs
  clone_id = 9000
  full_clone = true

  # !SECTION

  # SECTION Boot Process

  onboot = false 

  # NOTE Change startup, shutdown and auto reboot behavior
  startup = ""
  automatic_reboot = false

  # !SECTION

  # SECTION Hardware Settings

  qemu_os = "l26"
  bios = "seabios"
  memory = 4096
  cpu {
    cores = 4
    sockets = 1
    type = "host"
  }
  # NOTE Minimum memory of the balloon device, set to 0 to disable ballooning
  balloon = 4096
  
  # !SECTION

  # SECTION Network Settings

  network {
    id     = 0  # NOTE Required since 3.x.x
    bridge = "lab21"
    model  = "virtio"
  }

  # !SECTION

  # SECTION Disk Settings
  
  # NOTE Change the SCSI controller type, since Proxmox 7.3, virtio-scsi-single is the default one         
  scsihw = "virtio-scsi-single"
  
  # NOTE New disk layout (changed in 3.x.x)
  disks {
    ide {
      ide0 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          storage = "local-lvm"

          # NOTE Since 3.x.x size change disk size will trigger a disk resize
          size = "35G"

          # NOTE Enable IOThread for better disk performance in virtio-scsi-single
          #      and enable disk replication
          iothread = true
          replicate = false
        }
      }
    }
  }

  # !SECTION

  # SECTION Cloud Init Settings

  # FIXME Before deployment, adjust according to your network configuration
  #ipconfig0 = "ip=10.0.21.11/24,gw=10.0.21.1"
  #nameserver = "10.0.21.1"
  ipconfig0 = "ip=dhcp"
  ciuser = "skogen"
  sshkeys = file(var.PUBLIC_SSH_KEY)

  # !SECTION
}

output "vm_ip" {
  value = proxmox_vm_qemu.devbox.default_ipv4_address
}