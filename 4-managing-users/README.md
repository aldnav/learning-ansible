# Managing users

Ad-hoc usages:  

- down and dirty no particular use case

Some objectives

- add users to groups, etc...
- add an admin group
- different users on web server, db server, but same group

Module https://docs.ansible.com/ansible/2.9/modules/group_module.html#group-module

```
vagrant@controller:/vagrant/4-managing-users$ ansible all -m group -a "name=admin state=present" --become
localhost | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "gid": 1001,
    "name": "admin",
    "state": "present",
    "system": false
}
node-2 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "gid": 1001,
    "name": "admin",
    "state": "present",
    "system": false
}
node-1 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "gid": 1001,
    "name": "admin",
    "state": "present",
    "system": false
}
```

Add user accounts

https://docs.ansible.com/ansible/2.9/modules/user_module.html#user-module

```
vagrant@controller:/vagrant/4-managing-users$ ansible all -m user -a "name=daniel shell=/bin/bash groups=admin append=true" --become
localhost | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "comment": "",
    "create_home": true,
    "group": 1002,
    "groups": "admin",
    "home": "/home/daniel",
    "name": "daniel",
    "shell": "/bin/bash",
    "state": "present",
    "system": false,
    "uid": 1001
}
node-2 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "comment": "",
    "create_home": true,
    "group": 1002,
    "groups": "admin",
    "home": "/home/daniel",
    "name": "daniel",
    "shell": "/bin/bash",
    "state": "present",
    "system": false,
    "uid": 1001
}
node-1 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "comment": "",
    "create_home": true,
    "group": 1002,
    "groups": "admin",
    "home": "/home/daniel",
    "name": "daniel",
    "shell": "/bin/bash",
    "state": "present",
    "system": false,
    "uid": 1001
}
vagrant@controller:/vagrant/4-managing-users$
```

What about the passwords? Need to use other modules for that. You don't want to publish it with passwords.

https://docs.ansible.com/ansible/faq.html#how-do-i-generate-encrypted-passwords-for-the-user-module

## Groups

Developers group.
They don't need accounts on controller and dbservers.

```
vagrant@controller:/vagrant/4-managing-users$ ansible all -m user -a "name=daniel shell=/bin/bash groups=admin append=true" --become
vagrant@controller:/vagrant/4-managing-users$ ansible webservers -m group -a "name=developers state=present" --become
node-1 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "gid": 1003,
    "name": "developers",
    "state": "present",
    "system": false
}
vagrant@controller:/vagrant/4-managing-users$ ansible webservers -m user -a "name=justin shell=/bin/bash groups=developers" --become
node-1 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "comment": "",
    "create_home": true,
    "group": 1004,
    "groups": "developers",
    "home": "/home/justin",
    "name": "justin",
    "shell": "/bin/bash",
    "state": "present",
    "system": false,
    "uid": 1002
}
```

What if justin is an admin now too?

```
vagrant@controller:/vagrant/4-managing-users$ ansible webservers -m user -a "name=justin groups=admin" --become
node-1 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "append": false,
    "changed": true,
    "comment": "",
    "group": 1004,
    "groups": "admin",
    "home": "/home/justin",
    "move_home": false,
    "name": "justin",
    "shell": "/bin/bash",
    "state": "present",
    "uid": 1002
}
```
The group is overriden.

```
vagrant@controller:/vagrant/4-managing-users$ ansible webservers -m user -a "name=justin groups=admin,developers append=yes" --become
node-1 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "append": true,
    "changed": true,
    "comment": "",
    "group": 1004,
    "groups": "admin,developers",
    "home": "/home/justin",
    "move_home": false,
    "name": "justin",
    "shell": "/bin/bash",
    "state": "present",
    "uid": 1002
}
```

Add HR with only append
```
vagrant@controller:/vagrant/4-managing-users$ ansible webservers -m group -a "name=hr state=present" --become
node-1 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "gid": 1005,
    "name": "hr",
    "state": "present",
    "system": false
}
vagrant@controller:/vagrant/4-managing-users$ ansible webservers -m user -a "name=justin groups=hr append=yes" --become
node-1 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "append": true,
    "changed": true,
    "comment": "",
    "group": 1004,
    "groups": "hr",
    "home": "/home/justin",
    "move_home": false,
    "name": "justin",
    "shell": "/bin/bash",
    "state": "present",
    "uid": 1002
}
```

The change occur but not exhaustive. The group is differential. 

```
vagrant@node-1:~$ tail /etc/group
tss:x:116:
landscape:x:117:
systemd-coredump:x:999:
vagrant:x:1000:
netdev:x:118:
admin:x:1001:daniel,justin
daniel:x:1002:
developers:x:1003:justin
justin:x:1004:
hr:x:1005:justin
```

admin,developers,hr