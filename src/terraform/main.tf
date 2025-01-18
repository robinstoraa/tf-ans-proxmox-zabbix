resource "proxmox_virtual_environment_vm" "zabbix_vm" {
  name      = var.virtual_environment_vmname
  node_name = var.virtual_environment_nodename
  vm_id = var.vmid

  agent {
    enabled = true
  }

  # should be true if qemu agent is not installed / enabled on the VM
  stop_on_destroy = true

  initialization {
    datastore_id = var.virtual_environment_datastoreid  
    ip_config {
      ipv4 {
        address = join("/", [var.vmip, tostring(var.vmmask)])
        gateway = var.vmgateway
      }   
    }
    dns {
        servers = [var.vmdns1,var.vmdns2]
    }
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
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
    cores        = var.vmcpucores
    type         = "x86-64-v2-AES"  # recommended for modern CPUs
  }
  memory {
    dedicated = var.vmmemory
    floating  = var.vmmemory # set equal to dedicated to enable ballooning
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

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = var.virtual_environment_datastoreid
  node_name    = var.virtual_environment_nodename

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: ${var.virtual_environment_vmname}
    users:
    - name: ${var.virtual_environment_vmuser}
      gecos: ${var.virtual_environment_vmuser}
      sudo: ["ALL=(ALL) NOPASSWD:ALL"]
      shell: /bin/bash
      lock_passwd: false
      passwd: ${bcrypt(var.virtual_environment_vmpassword)}
    ssh_pwauth: true    
    runcmd:
        - apt update
        - apt install -y qemu-guest-agent net-tools
        - timedatectl set-timezone America/Toronto
        - systemctl enable qemu-guest-agent
        - systemctl start qemu-guest-agent
        - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "user-data-cloud-config.yaml"
  }
}