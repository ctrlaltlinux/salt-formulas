#!/bin/bash
## How to use this script
## 1. Create a new CentOS 6.4 VM
## 2. SSH to the new VM as root
## 3. Run: wget -qO- https://raw.github.com/ctrlaltlinux/salt-formulas/master/init.sh | sh

# Install EPEL and other software
yum install -y http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum install -y git salt-master salt-minion emacs-nox screen htop

# Chcekout the git repository
git clone https://github.com/ctrlaltlinux/salt-formulas.git /srv

# Start the SaltStack services
service salt-master start
service salt-minion start

# Wait for the minion to check in and then sign the key
sleep 10
salt-key -a '*' -y

# Finally, apply the Salt configuration
salt \* state.highstate
