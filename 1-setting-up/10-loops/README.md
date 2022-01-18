# Loops

Loops in the context of a Playbook

✅ Installation of packages
✅ Administering multiple users
✅ Repetitive tasks, etc.

Scenario:

Commision to setup a bunch of dev machines

- Git
- Vim
- Zsh

---

```yaml
--- # setup dev machines
- hosts: devmachines
  become: true
  tasks:
    - name: "install base packages"
      apt:
        name: "{{ item }}"
        state: present
      with_items:
        - git
        - vim
        - zsh
        - nodejs
    # - name: "install git"
    #   apt:
    #     name: git
    #     state: present
    # - name: "install vim"
    #   apt:
    #     name: vim
    #     state: present
    # - name: "install zsh"
    #   apt:
    #     name: zsh
    #     state: fixed  # this one somehow resolves --fix-missing
    # - name: "install nodejs"
    #   apt:
    #     name: nodejs
    #     state: fixed
```

```
vagrant@controller:/vagrant/10-loops$ ansible-playbook development-machine.yml

PLAY [devmachines] ********************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************
ok: [node-1]
ok: [node-2]

TASK [install base packages] **********************************************************************************************************
ok: [node-2] => (item=git)
ok: [node-1] => (item=git)
ok: [node-1] => (item=vim)
ok: [node-2] => (item=vim)
ok: [node-1] => (item=zsh)
ok: [node-2] => (item=zsh)
ok: [node-1] => (item=nodejs)
ok: [node-2] => (item=nodejs)

PLAY RECAP ****************************************************************************************************************************
node-1                     : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
node-2                     : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

vagrant@controller:/vagrant/10-loops$
```

Using vars and expansion

```yaml
--- # setup dev machines
- hosts: devmachines
  become: true
  vars:
    required_packages:
      - git
      - vim
      - zsh
      - nodejs
  tasks:
    - name: "install base packages"
      apt:
        name: "{{ item }}"
        state: present  # what if i want --fix-missing
      with_items: "{{ required_packages }}"
```

```
vagrant@controller:/vagrant/10-loops$ ansible-playbook development-machine.yml

PLAY [devmachines] ********************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************
ok: [node-1]
ok: [node-2]

TASK [install base packages] **********************************************************************************************************
ok: [node-1] => (item=git)
ok: [node-2] => (item=git)
ok: [node-1] => (item=vim)
ok: [node-2] => (item=vim)
ok: [node-1] => (item=zsh)
ok: [node-2] => (item=zsh)
ok: [node-1] => (item=nodejs)
ok: [node-2] => (item=nodejs)

PLAY RECAP ****************************************************************************************************************************
node-1                     : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
node-2                     : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

vagrant@controller:/vagrant/10-loops$
```

💡 The context of understanding come up as our playbooks become more complex.
Knowing a little bit. Move forward. Know a little bit. Move forward.

Then finally it's very powerful. I wouldn't understood how to use this other
complex portion until I got to this point.

❓Limitations using collections within playbooks?

Edge cases. Is the collection a list of strings? Or a list of objects?
What if I had those packages that was within that, it was a name and a state?
Using with the template module is tricky. **Context specific**

