# Getting Started with Roles

Using playbooks with portability. Meaning specific aspects can be used in other projects.

- Aspect for installing Apache or Nginx
- Aspect for deployment procedure
- Aspect for installing programs

Common things to do regardless of e.g. "installing node or not"

Roles applied depending on what's needed. Taking on attributes of respective roles.

In Ansible, a role is a set of properties that get applied to a single machine or multiple machines.

Say a development role. Setup git, zshell, vim.
Backend developers and web developers. They all need git, (zshell), and vim.
Maybe setup a developers group that is on the respective machines.
That is fairly common for both backend and web developers.
Then web developers need NodeJS — now we have the NodeJS role applied to only machines going to be used by web developers.
All backend stack is in Python, in Flask. All the backend developer machines need the backend developer role.

Common role is applied uniformly over and pick and choose the other pieces.

Roles are like Legos. Start with square based panel and needs specific pieces on the panel and to the other panel add other pieces.

Set properties and attributes that are true exists on a specific role.

---

## Setup

```ini
# hosts
[backend-developers]
node-1

[web-developers]
node-2

[devmachines:children]
web-developers
backend-developers
```

`devmachines:children` is an aggregate group called `devmachines` that has `web-developers` and `backend-developers` contained within it.

Based on this arrangement, machines `devmachines`, `web-developers`, `backend-developers` as the host groups within the playbook.

Roles are defined by projects.

```console
vagrant@controller:/vagrant/12-roles$ mkdir -p roles/common roles/nodejs roles/flask roles/frontendteam roles/backendteam
vagrant@controller:/vagrant/12-roles$ ls roles/*
roles/backendteam:

roles/common:

roles/flask:

roles/frontendteam:

roles/nodejs:
```

Skeleton on roles

```console
vagrant@controller:/vagrant/12-roles$ cd roles/common/
vagrant@controller:/vagrant/12-roles/roles/common$ mkdir files templates handlers tasks vars defaults
vagrant@controller:/vagrant/12-roles/roles/common$ ls -la
total 4
drwxr-xr-x 1 vagrant vagrant 256 Jan 21 11:21 .
drwxr-xr-x 1 vagrant vagrant 224 Jan 21 11:13 ..
drwxr-xr-x 1 vagrant vagrant  64 Jan 21 11:21 defaults
drwxr-xr-x 1 vagrant vagrant  64 Jan 21 11:21 files
drwxr-xr-x 1 vagrant vagrant  64 Jan 21 11:21 handlers
drwxr-xr-x 1 vagrant vagrant  64 Jan 21 11:21 tasks
drwxr-xr-x 1 vagrant vagrant  64 Jan 21 11:21 templates
drwxr-xr-x 1 vagrant vagrant  64 Jan 21 11:21 vars
```

Why put these folders?

The common roles evolve and you may need it.

## Roles and Tasks

Roles are a set of attributes that you can assign to a group of machines.

Giant playbook moved into roles.

```console
vagrant@controller:/vagrant/12-roles$ tree roles/
roles/
├── backendteam
├── common
│   ├── defaults
│   ├── files
│   ├── handlers
│   ├── tasks
│   ├── templates
│   └── vars
├── flask
├── frontendteam
└── nodejs
```

Within each of the roles defined, how does one make the task run?

### Filling out the tasks

Simple example on `roles/common/tasks/main.yml`

```yaml
--- # roles/common/tasks/main.yml
- name: "execute a shell command"
  shell: "ls -lah"
```

```console
vagrant@controller:/vagrant/12-roles$ ansible-playbook developer-with-roles.yml
[WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details

PLAY [devmachines] ************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [node-2]
ok: [node-1]

TASK [common : execute a shell command] ***************************************************************************************************************************************************************************
changed: [node-2]
changed: [node-1]

PLAY [web-developers] *********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [node-2]

PLAY [backend-developers] *****************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [node-1]

PLAY RECAP ********************************************************************************************************************************************************************************************************
node-1                     : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
node-2                     : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

Moving the tasks from developers to `roles/common/tasks/main.yml`

```yml
--- # common tasks

- name: "install common packages"
  apt:
    name: "{{ item }}"
    state: latest
  with_items:
    - git
    - zsh
    - vim
- name: "add developer group"
  group:
    name: "developers"
    state: present
```

```console
vagrant@controller:/vagrant/12-roles$ ansible-playbook developer-with-roles.yml
[WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details

PLAY [devmachines] ************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [node-1]
ok: [node-2]

TASK [common : install common packages] ***************************************************************************************************************************************************************************
ok: [node-2] => (item=git)
ok: [node-1] => (item=git)
changed: [node-2] => (item=zsh)
ok: [node-2] => (item=vim)
changed: [node-1] => (item=zsh)
ok: [node-1] => (item=vim)

TASK [common : add developer group] *******************************************************************************************************************************************************************************
changed: [node-2]
changed: [node-1]

PLAY [web-developers] *********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [node-2]

PLAY [backend-developers] *****************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [node-1]

PLAY RECAP ********************************************************************************************************************************************************************************************************
node-1                     : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
node-2                     : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

vagrant@controller:/vagrant/12-roles$
```

Here we see role-based description of tasks.

```console
TASK [common : install common packages] ***************************************************************************************************************************************************************************
ok: [node-2] => (item=git)
ok: [node-1] => (item=git)
changed: [node-2] => (item=zsh)
ok: [node-2] => (item=vim)
changed: [node-1] => (item=zsh)
ok: [node-1] => (item=vim)

TASK [common : add developer group] *******************************************************************************************************************************************************************************
changed: [node-2]
changed: [node-1]
```

Now moving the NodeJS chunk of task to nodejs role.

```yml
--- # roles/nodejs/tasks/main.yml

- name: "set up nodejs key"
  apt_key:
    url: "https://deb.nodesource.com/gpgkey/nodesource.gpg.key"
    state: present
- name: "set up nodejs repository"
  apt_repository:
    repo: "deb https://deb.nodesource.com/node_17.x impish main"
    state: present
- name: "install nodejs setup"
  apt:
    name: nodejs
    state: latest
- name: "set up users"
  user:
    name: "{{ item.username }}"
    groups:
      - developers
    shell: "{{ item.shell }}"
  with_items: "{{ users }}"
- name: "make a code directory"
  file:
    path: "/home/{{ item.username }}/code"
    state: directory
    owner: "{{ item.username }}"
    group: "{{ item.username }}"
  with_items: "{{ users }}"
```

```console
TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [node-2]

TASK [nodejs : set up nodejs key] *********************************************************************************************************************************************************************************
changed: [node-2]

TASK [nodejs : set up nodejs repository] **************************************************************************************************************************************************************************
changed: [node-2]

TASK [nodejs : install nodejs setup] ******************************************************************************************************************************************************************************
changed: [node-2]
TASK [nodejs : set up users] **************************************************************************************************************************************************************************************
changed: [node-2] => (item={'username': 'cherokee', 'shell': '/bin/bash'})
changed: [node-2] => (item={'username': 'aubri', 'shell': '/bin/zsh'})

TASK [nodejs : make a code directory] *****************************************************************************************************************************************************************************
changed: [node-2] => (item={'username': 'cherokee', 'shell': '/bin/bash'})
changed: [node-2] => (item={'username': 'aubri', 'shell': '/bin/zsh'})
```

Now moving other chunks.

```yml
--- # just see the yml files under roles ...
# it's way too many and too long
```

```console
vagrant@controller:/vagrant/12-roles$ ansible-playbook developer-with-roles.yml
[WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details

PLAY [devmachines] ************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [node-1]
ok: [node-2]

TASK [common : install common packages] ***************************************************************************************************************************************************************************
ok: [node-2] => (item=git)
ok: [node-1] => (item=git)
ok: [node-2] => (item=zsh)
ok: [node-1] => (item=zsh)
ok: [node-2] => (item=vim)
ok: [node-1] => (item=vim)

TASK [common : add developer group] *******************************************************************************************************************************************************************************
ok: [node-2]
ok: [node-1]

PLAY [web-developers] *********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [node-2]

TASK [frontendteam : set up users] ********************************************************************************************************************************************************************************
ok: [node-2] => (item={'username': 'cherokee', 'shell': '/bin/bash'})
ok: [node-2] => (item={'username': 'aubri', 'shell': '/bin/zsh'})

TASK [frontendteam : make a code directory] ***********************************************************************************************************************************************************************
ok: [node-2] => (item={'username': 'cherokee', 'shell': '/bin/bash'})
ok: [node-2] => (item={'username': 'aubri', 'shell': '/bin/zsh'})

TASK [nodejs : set up nodejs key] *********************************************************************************************************************************************************************************
ok: [node-2]

TASK [nodejs : set up nodejs repository] **************************************************************************************************************************************************************************
ok: [node-2]

TASK [nodejs : install nodejs setup] ******************************************************************************************************************************************************************************
ok: [node-2]

PLAY [backend-developers] *****************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [node-1]

TASK [backendteam : install the python3.9 distribution] ***********************************************************************************************************************************************************
ok: [node-1] => (item=python3.9)
ok: [node-1] => (item=python3-pip)

TASK [backendteam : set up users] *********************************************************************************************************************************************************************************
changed: [node-1] => (item={'username': 'justin', 'shell': '/bin/zsh'})
changed: [node-1] => (item={'username': 'daniel', 'shell': '/bin/bash'})

TASK [backendteam : make a code directory] ************************************************************************************************************************************************************************
changed: [node-1] => (item={'username': 'justin', 'shell': '/bin/zsh'})
changed: [node-1] => (item={'username': 'daniel', 'shell': '/bin/bash'})

TASK [flask : install Flask python framework] *********************************************************************************************************************************************************************
changed: [node-1]

PLAY RECAP ********************************************************************************************************************************************************************************************************
node-1                     : ok=8    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
node-2                     : ok=9    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```



⚠️ refusing to convert from file to symlink for /usr/bin/pip

```console
vagrant@node-1:~$ pip --version
pip 20.3.4 from /usr/lib/python3/dist-packages/pip (python 3.9)
vagrant@node-1:~$ pip3 --version
pip 20.3.4 from /usr/lib/python3/dist-packages/pip (python 3.9)
```

just skip the tasks. it's the same anyway.

💡 The task can grow but the roles stay the same

## Roles and Handlers

Scenario

Provision static sites to specific servers.

Make handlers and how to use it in roles?

Do they work the same?

