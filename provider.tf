terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "=2.7.4"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://192.168.1.230:8006/api2/json"
  pm_user = "terraform-prov@pve"
  pm_tls_insecure = true
}
