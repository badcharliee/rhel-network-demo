#!/bin/bash

# Set Security Group to allow inbound SSH traffic from CIDR Block of MyIP or known SSH Host Subnet (world for demo)
# Set Security Group to allow inbound Cockpit (port 9090) traffic from MyIP or known SSH Host Subnet (world for demo)

dnf install -y vim
dnf install -y cockpit
dnf install -y firewalld

systemctl enable --now firewalld
systemctl enable --now cockpit.socket