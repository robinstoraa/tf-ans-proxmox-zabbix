# Terraform Ansible Proxmox Zabbix
---
This tool contains 2 scripts.

The first script is a terraform script that deploys a new virtual machine and initializes it with cloud init to get ready for the zabbix installation.

The second script is an ansible playbook that downloads and configures Zabbix server, Postgresql and nginx on the previously created virtual machine. 