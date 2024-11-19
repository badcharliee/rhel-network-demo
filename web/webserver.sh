#!/bin/bash

# Set Route Table of Private Subnet to point to NAT Server Public IP for all Destination IPs

dnf install -y firewalld
dnf install -y cockpit
dnf install -y cockpit-pcp
dnf install -y httpd

systemctl enable --now firewalld
systemctl enable --now cockpit.socket
systemctl enable --now pmlogger.service
systemctl enable --now httpd.service

firewall-cmd --add-service=cockpit --permanent
firewall-cmd --add-service=https --permanent
firewall-cmd --add-service=http --permanent
firewall-cmd --reload