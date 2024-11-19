#!/bin/bash

###
# After deployment of servers, we need configure ssh profile on the bastion host
# For the sake of the demo, we will make one config file and share one key pair
###

# Write Profile definitions to local user's .ssh directory
cat <<EOF > ~/.ssh/config
Host bastion
 StrictHostKeyChecking no
 HostName <public-bastion-ip>
 IdentityFile ~/.ssh/rhel9-playground-key-pair.pem
 User ec2-user

Host nat
 StrictHostKeyChecking no
 HostName <private-nat-ip>
 IdentityFile ~/.ssh/rhel9-playground-key-pair.pem
 User ec2-user

Host webserver
 StrictHostKeyChecking no
 HostName <private-webserver-ip>
 IdentityFile ~/.ssh/rhel9-playground-key-pair.pem
 User ec2-user

Host webserver-backup
 StrictHostKeyChecking no
 HostName <private-webserver-backup-ip>
 IdentityFile ~/.ssh/rhel9-playground-key-pair.pem
 User ec2-user

Host firewall
 StrictHostKeyChecking no
 HostName <private-firewall-ip>
 IdentityFile ~/.ssh/rhel9-playground-key-pair.pem
 User ec2-user
EOF

# Move private key(s), which bastion needs to ssh into the rest of our network, into default user's .ssh directory
scp -i ./rhel9-playground-key-pair.pem ./rhel9-playground-key-pair.pem ec2-user@<public-bastion-ip>:/home/ec2-user/.ssh/
# Move config(s), which bastion needs to define ssh profiles, into default user's .ssh directory
scp -i ./rhel9-playground-key-pair.pem ./config ec2-user@<public-bastion-ip>:/home/ec2-user/.ssh/

# ssh into bastion server
ssh bastion
chmod 600 ~/.ssh/config # Make ssh config file readable, writable by owner (ec2-user)

# move key webserver needs to rsync with backup server
scp -i ~/.ssh/rhel9-playground-key-pair.pem ~/.ssh/rhel9-playground-key-pair.pem ec2-user@<private-webserver-ip>:/home/ec2-user/.ssh/
scp -i ~/.ssh/rhel9-playground-key-pair.pem ~/.ssh/config ec2-user@<private-webserver-ip>:/home/ec2-user/.ssh/



