resource "proxmox_virtual_environment_vm" "zabbix_vm" {
  name      = var.virtual_environment_vmname
  node_name = var.virtual_environment_nodename
  vm_id = var.vmid

  agent {
    enabled = false
  }

  # should be true if qemu agent is not installed / enabled on the VM
  stop_on_destroy = true

  initialization {
    datastore_id = var.virtual_environment_datastoreid
    user_account {
      # do not use this in production, configure your own ssh key instead!
      username = var.virtual_environment_vmuser
      password = var.virtual_environment_vmpassword
    }    
    ip_config {
      ipv4 {
        address = join("/", [var.vmip, tostring(var.vmmask)])
        gateway = var.vmgateway
      }
    }
    dns {
        servers = [var.vmdns1,var.vmdns2]
    }
  }
  disk {
    datastore_id = var.virtual_environment_datastoreid
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.virtual_environment_vmdisksize
  }
  cpu {
    cores        = 4
    type         = "x86-64-v2-AES"  # recommended for modern CPUs
  }
  memory {
    dedicated = 8192
    floating  = 8192 # set equal to dedicated to enable ballooning
  }
  network_device {
    bridge = var.networkbridge
  }
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = var.virtual_environment_datastoreid
  node_name    = var.virtual_environment_nodename
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}