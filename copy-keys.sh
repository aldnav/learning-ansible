#!/bin/bash

sshpass -p vagrant ssh-copy-id -i /home/vagrant/.ssh/id_rsa node-1
sshpass -p vagrant ssh-copy-id -i /home/vagrant/.ssh/id_rsa node-2
sshpass -p vagrant ssh-copy-id -i /home/vagrant/.ssh/id_rsa node-3