resource "proxmox_vm_qemu" "dhcp" {

  # SECTION General Settings

  name = "dhcp01"
  description = "dhcp01"
  agent = 1  # <-- (Optional) Enable QEMU Guest Agent

  # FIXME Before deployment, set the correct target node name
  target_node = var.pvenode

  # FIXME Before deployment, set the desired VM ID (must be unique on the target node)
  vmid = 101

  # !SECTION
  
  # SECTION Template Settings

  # FIXME Before deployment, set the correct template or VM name in the clone field
  #       or set full_clone to false, and remote "clone" to manage existing (imported) VMs
  clone_id = 9000
  full_clone = true

  # !SECTION

  # SECTION Boot Process

  onboot = true 

  # NOTE Change startup, shutdown and auto reboot behavior
  startup = ""
  automatic_reboot = false

  # !SECTION

  # SECTION Hardware Settings

  qemu_os = "l26"
  bios = "seabios"
  memory = 2048
  cpu {
    cores = 2
    sockets = 1
    type = "host"
  }
  # NOTE Minimum memory of the balloon device, set to 0 to disable ballooning
  balloon = 2048
  
  # !SECTION

  # SECTION Network Settings

  network {
    id     = 0  # NOTE Required since 3.x.x
    bridge = "lab29"
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
  ipconfig0 = "ip=10.0.29.254/24,gw=10.0.29.1"
  nameserver = "10.0.29.12"
  ciuser = "skogen"
  searchdomain = "lab.skog.network"
  sshkeys = file(var.PUBLIC_SSH_KEY)

  # !SECTION
}

output "vm_ip_dhcp" {
  value = proxmox_vm_qemu.dhcp.default_ipv4_address
  description = "Assigned IP Address"
}
