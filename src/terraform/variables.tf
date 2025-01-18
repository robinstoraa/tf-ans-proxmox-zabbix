variable "virtual_environment_username" {
  type = string
  description = "Virtual environment username"
}

variable "virtual_environment_password" {
  type = string
  description = "Virtual environment password"
  sensitive = true
}

variable "virtual_environment_endpoint" {
  type = string
  description = "Virtual environment endpoint"
}

variable "virtual_environment_datastoreid" {
  type = string
  description = "Virtual environment datastore id"
}

variable "virtual_environment_vmname" {
  type = string
  description = "Virtual environment vm name"
}

variable "virtual_environment_vmuser" {
  type = string
  description = "Virutal environment vm user"
}

variable "virtual_environment_vmpassword" {
  type = string
  description = "Virtual environment vm password"
  sensitive = true
}

variable "vmip" {
  type = string
  description = "VM IP"
}

variable "vmid" {
  type = number
  description = "VM ID"
}

variable "virtual_environment_nodename" {
  type = string
  description = "Virtual environment node name"
}

variable "virtual_environment_vmdisksize" {
  type = number
  description = "Virtual environment vm disk size"
}