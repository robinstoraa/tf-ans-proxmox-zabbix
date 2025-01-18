#!/bin/bash
source .env
ansible-playbook -i src/ansible/inventory.yml src/ansible/playbook.ansible.yml