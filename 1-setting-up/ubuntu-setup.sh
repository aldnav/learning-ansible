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
10.10.10.12 node-1
10.10.10.13 fedora-node
" >> /etc/hosts

ssh-keyscan node1 node2 node3 fedora-node >> /home/vagrant/.ssh/known_hosts

chown -R vagrant:vagrant /home/vagrant/.ssh