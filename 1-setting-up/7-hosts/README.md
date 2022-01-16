# Playbooks, Hosts, Tasks, Variables, Handlers

## Playbooks

For reproducible configurations

Avoid Configuration drift

A set of description of nodes and what has to be setup

Can be put on a version control

Satifies a set of constraint for Ansible to run

* Hosts
* Variables
* Tasks
* Handlers
* Settings

Reminders

- Escalating privileges
- yes/no is now enforced boolean true/false by Ansible lint
- remote user


```
vagrant@controller:/vagrant/7-hosts$ ansible-playbook application.yml

PLAY [local] *********************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************
ok: [localhost]

PLAY [webservers] ****************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************
ok: [node-1]

PLAY [dbservers] *****************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************
ok: [node-2]

PLAY RECAP ***********************************************************************************************************************************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
node-1                     : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
node-2                     : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

vagrant@controller:/vagrant/7-hosts$
```

```yaml
---  # application: hosts
- hosts: local
  become: true

- hosts: webservers
  become: true

- hosts: dbservers
  become: true
```

## Tasks

Order is context-based. Disjoint. Needs to check on dependencies. The order is how they are listed in the task section.

```yaml
--- # server.yaml: installs nginx for static web host

- hosts: webservers
  become: yes
  tasks:
    - name: "install nginx"
      apt:
        name: nginx
        state: present
    - name: "start nginx"
      service:
        name: nginx
        state: started
```
```
vagrant@controller:/vagrant/7-hosts$ ansible-playbook server.yml

PLAY [webservers] ****************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************
ok: [node-1]

TASK [install nginx] *************************************************************************************************************************************************************************
ok: [node-1]

TASK [start nginx] ***************************************************************************************************************************************************************************
ok: [node-1]

PLAY RECAP ***********************************************************************************************************************************************************************************
node-1                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

## Variables

Variables can provide user information to a configuration

Don't hardcode credentials in a playbook

1. Inline variables

```yaml
--- # explore the use of variables

- hosts: webservers
  vars:
    home: "/home/vagrant"
    pictures_folder: "/home/vagrant/pictures"
  tasks:
    - name: "create a file in the home directory"
      file:
        path: "{{ home }}/awesome.txt"
        state: file
    - name: "create the pictures folder"
      file:
        path: "{{ pictures_folder }}"
        state: directory
```

2. Vars and files

Use in multiple playbooks, or re-organize, what port to open up? 
Variables from within the file.

Can I still use vars with vars_file defined?

vars_files takes precedence over inline variables

```yaml
--- # statics.yaml contains all variables pertaining to static assets

home: "/home/vagrant"
pictures_folder: "/home/vagrant/pictures"

--- # yourapp.yaml
  - hosts: webservers
  vars_files:
    - ./statics.yml
```

⚠️   Still not a good place to store passwords in the vars files
⭐️   It is better to use interactive prompts
⭐️⭐️ Put in an environment variable on that remote server using appropriate protocols


3. Interactive prompts

```yaml
  vars_prompt:
    - name: "home"
      prompt: "Where is the home directory?"
      private: no
      default: "/home/vagrant"
    - name: "pictures_folder"
      prompt: "Where should the pictures be stored?"
      private: no
      default: "/home/vagrant/pictures"
    - name: "password"
      prompt: "What is the password?"
      private: yes
```

4. CLI arguments

```
vagrant@controller:/vagrant/7-hosts$ ansible-playbook simple-variables.yml --extra-vars "home=/home/vagrant pictures_folder=/home/vagrant/pictures password=password1234"

PLAY [webservers] *******************************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************************
ok: [node-1]

TASK [create a file in the home directory] ******************************************************************************************************************************************************
ok: [node-1]

TASK [create the pictures folder] ***************************************************************************************************************************************************************
ok: [node-1]

TASK [put password in awesome.txt] **************************************************************************************************************************************************************
changed: [node-1]

PLAY RECAP **************************************************************************************************************************************************************************************
node-1                     : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

vagrant@controller:/vagrant/7-hosts$ ssh node-1
Welcome to Ubuntu 21.10 (GNU/Linux 5.13.0-21-generic aarch64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sun Jan 16 02:46:26 PM UTC 2022

  System load:  0.07               Processes:             193
  Usage of /:   36.7% of 18.04GB   Users logged in:       1
  Memory usage: 42%                IPv4 address for eth1: 10.10.10.11
  Swap usage:   0%


34 updates can be applied immediately.
24 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable


Last login: Sun Jan 16 14:46:16 2022 from 10.10.10.10
vagrant@node-1:~$ head awesome.txt
hellothisisasectert
password1234
```

