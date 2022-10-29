qm create 9001 --name "ubuntu-2004-cloudinit-template" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 9001 focal-server-cloudimg-amd64.img local-lvm
qm set 9001 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9001-disk-0
qm set 9001 --boot c --bootdisk scsi0
qm set 9001 --ide2 local-lvm:cloudinit
qm set 9001 --serial0 socket --vga serial0
qm set 9001 --agent enabled=1


qm clone 9001 999 --name test-clone-cloud-init

qm set 999 --sshkey "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDI8MLZLcn9dHNPgLXvqp5XxcQP6F1eRzPtQdRPQYxQCYPaJsZ9wrHaEDPVoLcH1YrRDEIW6pR0G1zuvXfwpomY2sFT2SJBagEeq71mTSZE50x3ZmXBq/O1XaN1zhCnSYpKYHtaDigg0ZciM7C6GDAxK7NR6IJoJywUkUr/d2CmQftEPMCbWMbv4GULsrILhpED5/GtANpM4LmSvAMKn87lZiy05j43yrmxWepnCO1izEobrz76RyJWUmOcsaSs/xpdArz3S7fjPm7S/Ey+0qxmJJqMC9CEVSa/ZuiLIYesARy+Gv7ZWZ2B3bBqZ2sglq3JLYuExQivnO4uYdW7m96G3zTEqV+qldjIP4NzmhfnHdKIt2SIu+5ipsD7zUWzmzc2o8I8oRc2IOZrsTNxatpZ5VDIf5v5pkqqR9xGGcD6KCmAtG/O15ZC8IN+grRSs0eHlH4mtK1vAKv53UTdR9Giy6owzaifPXaQUBo3TVrMzXSaJM4KuxkmojyUYWU+UsFSn/MIE6+js4MJCQyJeGz6vbzUktNBkxrHbBysguanMxyiTTs4d7eIMMKKl4BwkAbZx6DDDb8Z50P2+ntVvmAUK4e7Kbbqjs7SYR0I9GLpFxrSbHz37cNL/0BOI04TTXvVN7Z8DhjRPOMP2vrMdmEraTOb5lbXQ3kLcAU3213RYQ== vagrant@wb.local"

qm set 999 --ipconfig0 ip=192.168.1.99/24,gw=192.168.1.254