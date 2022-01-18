# Templating

Templating by Jinja2

In the beginning, templating is task-based but may use variables.

Tasks:

- Put a message that lets the admin know that the machine is setup.

```yaml
---  # Demo templating features
- hosts: webservers
  become: true
  vars:
    message_for_admin: "Hello admin, it is a nice day"
  tasks:
    - name: "template a nice message for admins"
      template:
        src: ./message.j2
        dest: /tmp/message
```

```
vagrant@controller:/vagrant/9-templating$ ansible-playbook forfun.yml

PLAY [webservers] *********************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************
ok: [node-1]

TASK [template a nice message for admins] *********************************************************************************************
changed: [node-1]

PLAY RECAP ****************************************************************************************************************************
node-1                     : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

vagrant@controller:/vagrant/9-templating$ ssh node-1
Welcome to Ubuntu 21.10 (GNU/Linux 5.13.0-25-generic aarch64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Jan 18 01:43:59 AM UTC 2022

  System load:  0.0                Processes:             191
  Usage of /:   40.1% of 18.04GB   Users logged in:       0
  Memory usage: 43%                IPv4 address for eth0: 192.168.185.178
  Swap usage:   0%                 IPv4 address for eth1: 10.10.10.11


10 updates can be applied immediately.
To see these additional updates run: apt list --upgradable


Last login: Tue Jan 18 01:43:51 2022 from 10.10.10.10
vagrant@node-1:~$ cat /tmp/message
Hello admin, it is a nice dayvagrant@node-1:~$
```

More vars

```yaml
---  # Demo templating features
- hosts: webservers
  become: true
  vars:
    message_for_admin: "Hello admin, it is a nice day"
    ips:
      - "10.10.10.11"
      - "10.10.10.12"
    some_data: "cheese"
  tasks:
    - name: "template a nice message for admins"
      template:
        src: ./message.j2
        dest: /tmp/message
    - name: "setup ip configuration"
      template:
        src: ./ip.conf.j2
        dest: /tmp/ip.conf
```

```j2
# ip.conf.j2
{{ ips }}
```

```
vagrant@node-1:~$ cat /tmp/ip.conf
['10.10.10.11', '10.10.10.12']vagrant@node-1:~$
```

```j2
{{ ips | to_json }}
```
```
vagrant@node-1:~$ cat /tmp/ip.conf
["10.10.10.11", "10.10.10.12"]vagrant@node-1:~$
```

```j2
# {{ ips | to_json }}

{% for ip in ips %}
{{ ip }}
{% endfor %}
```
```
vagrant@node-1:~$ cat /tmp/ip.conf
# ["10.10.10.11", "10.10.10.12"]

10.10.10.11
10.10.10.12
```

## Setting up a more complex template.

```yaml
---  # Demo templating features
- hosts: webservers
  become: true
  vars:
    message_for_admin: "Hello admin, it is a nice day"
    ips:
      - "10.10.10.11"
      - "10.10.10.12"
    some_data: "cheese"
    users:
      - name: Cardo
        username: cardodalisay
        shell: /bin/sh
      - name: Alyana
        username: Alyana
        shell: /bin/sh
      - { name: "Ingo", username: "superingo", shell: "/bin/bash" }
  tasks:
    - name: "template a nice message for admins"
      template:
        src: ./templates/message.j2
        dest: /tmp/message
    - name: "setup ip configuration"
      template:
        src: ./templates/ip.conf.j2
        dest: /tmp/ip.conf
    - name: "setup user configurations"
      template:
        src: ./templates/users.xml.j2
        dest: /tmp/users.xml
```

```
vagrant@node-1:~$ cat /tmp/users.xml
<Users>
    <User>
    <Name>Cardo</Name>
    <Username>cardodalisay</Username>
    <Shell>/bin/sh</Shell>
    </User>
    <User>
    <Name>Alyana</Name>
    <Username>Alyana</Username>
    <Shell>/bin/sh</Shell>
    </User>
    <User>
    <Name>Ingo</Name>
    <Username>superingo</Username>
    <Shell>/bin/bash</Shell>
    </User>
</Users>
```