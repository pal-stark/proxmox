resource "proxmox_vm_qemu" "proxmox_vm" {
  count             = 1
  name              = "test-vm"
  target_node       = "pve"
clone             = "debian-cloudinit"
os_type           = "cloud-init"
  cores             = 4
  sockets           = "1"
  cpu               = "host"
  memory            = 2048
  scsihw            = "virtio-scsi-pci"
  bootdisk          = "scsi0"
disk {

    size            = "20G"
    type            = "scsi"
    storage         = "Data"
  }
network {
    model           = "virtio"
    bridge          = "vmbr0"
  }
lifecycle {
    ignore_changes  = [
      network,
    ]
  }
# Cloud Init Settings
  ipconfig0 = "ip=192.168.1.100/24,gw=192.168.1.254"
sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}