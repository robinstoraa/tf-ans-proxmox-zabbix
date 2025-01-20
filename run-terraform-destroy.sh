#!/bin/bash
source .env
cd src/terraform
terraform plan -destroy
terraform destroy
