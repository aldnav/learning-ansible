# Running Commands

What if there are no modules for my task?

- Write own module
- Third-party module
- Maybe not known

Figure out disk usage

`du -h`

Memory usage

`df -h`

```
vagrant@controller:/vagrant/6-running-commands$ ansible all -m shell -a "du -h"
localhost | CHANGED | rc=0 >>
39K	.
node-1 | CHANGED | rc=0 >>
136K	./.ansible/tmp/ansible-tmp-1642219326.2564108-4673-61228950382189
136K	./.ansible/tmp/ansible-tmp-1642280481.6605928-1763-88228031582430
276K	./.ansible/tmp
280K	./.ansible
4.0K	./.cache
4.0K	./.config/procps
8.0K	./.config
8.0K	./.local/share/nvim/shada
12K	./.local/share/nvim
16K	./.local/share
20K	./.local
8.0K	./.ssh
348K	.
node-2 | CHANGED | rc=0 >>
136K	./.ansible/tmp/ansible-tmp-1642219326.2586365-4675-146166996794816
136K	./.ansible/tmp/ansible-tmp-1642280481.7526145-1765-162754661891923
276K	./.ansible/tmp
280K	./.ansible
4.0K	./.cache
4.0K	./.config/procps
8.0K	./.config
8.0K	./.local/share/nvim/shada
12K	./.local/share/nvim
16K	./.local/share
20K	./.local
8.0K	./.ssh
352K	.
vagrant@controller:/vagrant/6-running-commands$ ansible all -m shell -a "df -h"
localhost | CHANGED | rc=0 >>
Filesystem                         Size  Used Avail Use% Mounted on
tmpfs                               47M  1.2M   46M   3% /run
/dev/mapper/ubuntu--vg-ubuntu--lv   19G  7.1G   11G  42% /
tmpfs                              232M  124K  232M   1% /dev/shm
tmpfs                              5.0M     0  5.0M   0% /run/lock
/dev/nvme0n1p2                     974M   87M  820M  10% /boot
/dev/nvme0n1p1                     511M  3.6M  508M   1% /boot/efi
tmpfs                               47M  4.0K   47M   1% /run/user/1000
node-2 | CHANGED | rc=0 >>
Filesystem                         Size  Used Avail Use% Mounted on
tmpfs                               47M  1.2M   46M   3% /run
/dev/mapper/ubuntu--vg-ubuntu--lv   19G  7.7G  9.5G  45% /
tmpfs                              232M     0  232M   0% /dev/shm
tmpfs                              5.0M     0  5.0M   0% /run/lock
/dev/nvme0n1p2                     974M   87M  820M  10% /boot
/dev/nvme0n1p1                     511M  3.6M  508M   1% /boot/efi
tmpfs                               47M  4.0K   47M   1% /run/user/1000
node-1 | CHANGED | rc=0 >>
Filesystem                         Size  Used Avail Use% Mounted on
tmpfs                               47M  1.2M   46M   3% /run
/dev/mapper/ubuntu--vg-ubuntu--lv   19G  6.6G   11G  39% /
tmpfs                              232M     0  232M   0% /dev/shm
tmpfs                              5.0M     0  5.0M   0% /run/lock
/dev/nvme0n1p2                     974M   87M  820M  10% /boot
/dev/nvme0n1p1                     511M  3.6M  508M   1% /boot/efi
tmpfs                               47M  4.0K   47M   1% /run/user/1000
vagrant@controller:/vagrant/6-running-commands$
```

We should be able to command without a module or a sole module to issue a command.

Trying PING from nodes

```
vagrant@controller:/vagrant/6-running-commands$ ansible all -m shell -a "ping -c 1 8.8.8.8"
localhost | CHANGED | rc=0 >>
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=128 time=89.8 ms

--- 8.8.8.8 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 89.755/89.755/89.755/0.000 ms
node-1 | CHANGED | rc=0 >>
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=128 time=68.1 ms

--- 8.8.8.8 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 68.088/68.088/68.088/0.000 ms
node-2 | CHANGED | rc=0 >>
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=128 time=74.6 ms

--- 8.8.8.8 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 74.556/74.556/74.556/0.000 ms
```

Internet is down. Or no doc access.

Module `shell` for quick and dirty commands.

Take note:

- Aware as running as user
- Best to use absolute path

Piping works

```
vagrant@controller:/vagrant/6-running-commands$ ansible webservers -m shell -a "cat /etc/group | grep vagrant"
node-1 | CHANGED | rc=0 >>
adm:x:4:syslog,vagrant
cdrom:x:24:vagrant
sudo:x:27:vagrant
dip:x:30:vagrant
plugdev:x:46:vagrant
lxd:x:110:vagrant
vagrant:x:1000:
```

Absolute path. Free memory.
```
vagrant@controller:/vagrant/6-running-commands$ ansible all -m shell -a "du -h /home/vagrant/.cache/"
localhost | CHANGED | rc=0 >>
4.0K	/home/vagrant/.cache/nvim
8.0K	/home/vagrant/.cache/
node-2 | CHANGED | rc=0 >>
4.0K	/home/vagrant/.cache/
node-1 | CHANGED | rc=0 >>
4.0K	/home/vagrant/.cache/
vagrant@controller:/vagrant/6-running-commands$ ansible all -m shell -a "free -h"
localhost | CHANGED | rc=0 >>
               total        used        free      shared  buff/cache   available
Mem:           462Mi       227Mi       6.0Mi       1.0Mi       228Mi       227Mi
Swap:          3.8Gi       1.0Mi       3.8Gi
node-1 | CHANGED | rc=0 >>
               total        used        free      shared  buff/cache   available
Mem:           462Mi       155Mi        25Mi       1.0Mi       281Mi       296Mi
Swap:          3.8Gi          0B       3.8Gi
node-2 | CHANGED | rc=0 >>
               total        used        free      shared  buff/cache   available
Mem:           462Mi       178Mi        15Mi       1.0Mi       268Mi       271Mi
Swap:          3.8Gi        37Mi       3.8Gi
```

What else?

- command
- raw

## Shell

Piping and redirecting. What you would do in bash shell.

## Raw

https://docs.ansible.com/ansible/2.9/modules/raw_module.html#raw-module

Low-level SSH issuance of a command on a remote host.

**Why raw?**

`/usr/bin/python` and `python` has to be installed on hosts. Make modifications to the host in absence of this requirement. 

💡 Tips

To avoid going over and modify all hosts and needed to do only a couple of changes.

1. Hop into one host
2. Figure out the changes
3. Write ansible command and then Farm out the command and run on other hosts and make sure that it works

`ansible node-1 -m raw -a "sudo apt-get install python2.7 -y"`

`ansible node-1 -m raw -a "sudo ln -s /usr/bin/python2.7 /usr/bin/python`

## Command

https://docs.ansible.com/ansible/2.9/modules/command_module.html#command-module

Almost like the shell, but no redirects, no pings, no pipings, no bash operator. (Provide input?)

```
vagrant@controller:/vagrant/6-running-commands$ ansible webservers -m shell -a "touch /tmp/file.txt"
node-1 | CHANGED | rc=0 >>

vagrant@controller:/vagrant/6-running-commands$ ansible webservers -m command -a "touch /tmp/command_file.txt"
node-1 | CHANGED | rc=0 >>

vagrant@controller:/vagrant/6-running-commands$
```

Looks identical, right?

```
vagrant@controller:/vagrant/6-running-commands$ ansible webservers -m shell -a "echo 'shell' >> /tmp/file.txt"
node-1 | CHANGED | rc=0 >>

vagrant@controller:/vagrant/6-running-commands$ ansible webservers -m command -a "echo 'command' >> /tmp/command_file.txt"
node-1 | CHANGED | rc=0 >>
command >> /tmp/command_file.txt

vagrant@node-1:~$ cat /tmp/*file.txt
shell
vagrant@node-1:~$ cat /tmp/command_file.txt
vagrant@node-1:~$
```

🤯 `command_file.txt` is blank.

Redirects, appends, piping, it is recommended to use the `shell` module instead. Here's what the documentation says,

> The command(s) will not be processed through the shell, so variables like $HOME and operations like "<", ">", "|", ";" and "&" will not work. Use the shell module if you need these features.

When is `command` useful?

Piping, redirects, etc., are removed from capabilities because user input is now sanitized.

