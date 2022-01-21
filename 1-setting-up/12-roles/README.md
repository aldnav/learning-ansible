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

```
vagrant@controller:/vagrant/12-roles$ mkdir -p roles/common roles/nodejs roles/flask roles/frontendteam roles/backendteam
vagrant@controller:/vagrant/12-roles$ ls roles/*
roles/backendteam:

roles/common:

roles/flask:

roles/frontendteam:

roles/nodejs:
```

Skeleton on roles

```
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
