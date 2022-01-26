#!/bin/bash
apt-get update
apt-get install software-properties-common -y
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install ansible -y

ssh-keygen -t rsa -b 2048 -f /home/vagrant/.ssh/id_rsa

echo "

10.10.10.10 controller
10.10.10.11 node-1
10.10.10.12 node-2
10.10.10.13 node-3
" >> /etc/hosts

ssh-keyscan node-1 node-2 node-3 >> /home/vagrant/.ssh/known_hosts

chown -R vagrant:vagrant /home/vagrant/.ssh 