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

variable "vmmask" {
  type = number
  description = "Subnet mask in / notation"
}

variable "virtual_environment_nodename" {
  type = string
  description = "Virtual environment node name"
}

variable "virtual_environment_vmdisksize" {
  type = number
  description = "Virtual environment vm disk size"
}

variable "vmgateway" {
  type = string
  description = "Virtual machine gateway"
}

variable "vmdns1" {
  type = string
  description = "VM DNS 1"
}

variable "vmdns2" {
  type = string
  description = "VM DNS 2"
}

variable "networkbridge" {
  type = string
  description = "Network bridge"
}

variable "vmcpucores" {
  type = number
  description = "VM CPU cores"
}

variable "vmmemory" {
  type = number
  description = "VM Memory in MiB"
}

variable "vmtimezone" {
  type = string
  description = "VM Timezone"
}