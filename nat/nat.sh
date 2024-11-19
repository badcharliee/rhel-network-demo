#!/bin/bash

# Set Security Group to allow inbound traffic from CIDR Block of Private Subnet
# Set Security Group to allow inbound traffic from MyIP for port 9090 (Cockpit)

dnf install -y vim
dnf install -y cockpit
dnf install -y firewalld

systemctl enable --now firewalld
systemctl enable --now cockpit.socket

firewall-cmd --zone=public --add-masquerade --permanent # Enabling server as NAT Gateway
firewall-cmd --reload