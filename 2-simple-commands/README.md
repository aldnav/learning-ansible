# Server

Server blocks are delimited described by resources. Chunked based on *roles*.

```
vagrant@controller:/vagrant/simple-commands$ ansible all -m ping
node-1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
10.10.10.12 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
vagrant@controller:/vagrant/simple-commands$ ansible dbservers -m ping
node-2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
vagrant@controller:/vagrant/simple-commands$ ansible webservers -m ping
node-1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
vagrant@controller:/vagrant/simple-commands$ ansible webserver -m ping
[WARNING]: Could not match supplied host pattern, ignoring: webserver
[WARNING]: No hosts matched, nothing to do
vagrant@controller:/vagrant/simple-commands$ ansible all -m shell -a "uname"
node-1 | CHANGED | rc=0 >>
Linux
node-2 | CHANGED | rc=0 >>
Linux
vagrant@controller:/vagrant/simple-commands$ ansible all -m shell -a "cat /etc/passwd"
node-1 | CHANGED | rc=0 >>
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
_apt:x:100:65534::/nonexistent:/usr/sbin/nologin
systemd-timesync:x:101:101:systemd Time Synchronization,,,:/run/systemd:/usr/sbin/nologin
systemd-network:x:102:103:systemd Network Management,,,:/run/systemd:/usr/sbin/nologin
systemd-resolve:x:103:104:systemd Resolver,,,:/run/systemd:/usr/sbin/nologin
messagebus:x:104:105::/nonexistent:/usr/sbin/nologin
pollinate:x:105:1::/var/cache/pollinate:/bin/false
sshd:x:106:65534::/run/sshd:/usr/sbin/nologin
syslog:x:107:113::/home/syslog:/usr/sbin/nologin
uuidd:x:108:114::/run/uuidd:/usr/sbin/nologin
tcpdump:x:109:115::/nonexistent:/usr/sbin/nologin
tss:x:110:116:TPM software stack,,,:/var/lib/tpm:/bin/false
landscape:x:111:117::/var/lib/landscape:/usr/sbin/nologin
systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
vagrant:x:1000:1000:vagrant:/home/vagrant:/bin/bash
lxd:x:998:100::/var/snap/lxd/common/lxd:/bin/false
node-2 | CHANGED | rc=0 >>
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
_apt:x:100:65534::/nonexistent:/usr/sbin/nologin
systemd-timesync:x:101:101:systemd Time Synchronization,,,:/run/systemd:/usr/sbin/nologin
systemd-network:x:102:103:systemd Network Management,,,:/run/systemd:/usr/sbin/nologin
systemd-resolve:x:103:104:systemd Resolver,,,:/run/systemd:/usr/sbin/nologin
messagebus:x:104:105::/nonexistent:/usr/sbin/nologin
pollinate:x:105:1::/var/cache/pollinate:/bin/false
sshd:x:106:65534::/run/sshd:/usr/sbin/nologin
syslog:x:107:113::/home/syslog:/usr/sbin/nologin
uuidd:x:108:114::/run/uuidd:/usr/sbin/nologin
tcpdump:x:109:115::/nonexistent:/usr/sbin/nologin
tss:x:110:116:TPM software stack,,,:/var/lib/tpm:/bin/false
landscape:x:111:117::/var/lib/landscape:/usr/sbin/nologin
systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
vagrant:x:1000:1000:vagrant:/home/vagrant:/bin/bash
lxd:x:998:100::/var/snap/lxd/common/lxd:/bin/false
```

Shell gives a low level access

```
vagrant@controller:/vagrant/simple-commands$ ansible all -m shell -a "cat /etc/hosts"
node-1 | CHANGED | rc=0 >>
127.0.0.1 localhost
127.0.1.1 vagrant

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
127.0.2.1 node-1 node-1
node-2 | CHANGED | rc=0 >>
127.0.0.1 localhost
127.0.1.1 vagrant

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
127.0.2.1 node-2 node-2
vagrant@controller:/vagrant/simple-commands$ ansible all -m shell -a "uptime"
node-2 | CHANGED | rc=0 >>
 04:01:28 up  1:47,  1 user,  load average: 0.00, 0.00, 0.00
node-1 | CHANGED | rc=0 >>
 04:01:28 up  1:48,  1 user,  load average: 0.07, 0.02, 0.00
```

Top

```
vagrant@controller:/vagrant/simple-commands$ ansible all -m shell -a "top"
# freeze
```

# Modules

The complete list of modules can be seen here: https://docs.ansible.com/ansible/2.9/modules/list_of_all_modules.html

Ad-hoc commands

- update-cache
- update

```
vagrant@controller:/vagrant/simple-commands$ ansible webservers -m apt -a "update_cache=yes"
node-1 | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "msg": "Failed to lock apt for exclusive operation: Failed to lock directory /var/lib/apt/lists/: E:Could not open lock file /var/lib/apt/lists/lock - open (13: Permission denied)"
}
```

Needs to escalate privileges.

```
vagrant@controller:/vagrant/simple-commands$ ansible webservers -m apt -a "update_cache=yes" --become
# takes a long time
# then fails
node-1 | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "msg": "Failed to update apt cache: unknown reason"
}
```

I get this on the actual node-1
```
vagrant@node-1:~$ sudo apt-get update -y
Ign:1 http://de.ports.ubuntu.com/ubuntu-ports impish InRelease
Ign:2 http://de.ports.ubuntu.com/ubuntu-ports impish-updates InRelease
Ign:3 http://de.ports.ubuntu.com/ubuntu-ports impish-backports InRelease
Ign:4 http://de.ports.ubuntu.com/ubuntu-ports impish-security InRelease
Ign:1 http://de.ports.ubuntu.com/ubuntu-ports impish InRelease
Ign:2 http://de.ports.ubuntu.com/ubuntu-ports impish-updates InRelease
Ign:3 http://de.ports.ubuntu.com/ubuntu-ports impish-backports InRelease
Ign:4 http://de.ports.ubuntu.com/ubuntu-ports impish-security InRelease
Ign:1 http://de.ports.ubuntu.com/ubuntu-ports impish InRelease
Ign:2 http://de.ports.ubuntu.com/ubuntu-ports impish-updates InRelease
Ign:3 http://de.ports.ubuntu.com/ubuntu-ports impish-backports InRelease
Ign:4 http://de.ports.ubuntu.com/ubuntu-ports impish-security InRelease
Err:1 http://de.ports.ubuntu.com/ubuntu-ports impish InRelease
  Temporary failure resolving 'de.ports.ubuntu.com'
Err:2 http://de.ports.ubuntu.com/ubuntu-ports impish-updates InRelease
  Temporary failure resolving 'de.ports.ubuntu.com'
Err:3 http://de.ports.ubuntu.com/ubuntu-ports impish-backports InRelease
  Temporary failure resolving 'de.ports.ubuntu.com'
Err:4 http://de.ports.ubuntu.com/ubuntu-ports impish-security InRelease
  Temporary failure resolving 'de.ports.ubuntu.com'
Reading package lists... Done
W: Failed to fetch http://de.ports.ubuntu.com/ubuntu-ports/dists/impish/InRelease  Temporary failure resolving 'de.ports.ubuntu.com'
W: Failed to fetch http://de.ports.ubuntu.com/ubuntu-ports/dists/impish-updates/InRelease  Temporary failure resolving 'de.ports.ubuntu.com'
W: Failed to fetch http://de.ports.ubuntu.com/ubuntu-ports/dists/impish-backports/InRelease  Temporary failure resolving 'de.ports.ubuntu.com'
W: Failed to fetch http://de.ports.ubuntu.com/ubuntu-ports/dists/impish-security/InRelease  Temporary failure resolving 'de.ports.ubuntu.com'
W: Some index files failed to download. They have been ignored, or old ones used instead.
```

Trying upgrade

```
vagrant@controller:/vagrant/simple-commands$ ansible webservers -m apt -a "upgrade=yes" --become --verbose
Using /vagrant/simple-commands/ansible.cfg as config file
node-1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "msg": "Reading package lists...\nBuilding dependency tree...\nReading state information...\nCalculating upgrade...\n0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.\n",
    "stderr": "",
    "stderr_lines": [],
    "stdout": "Reading package lists...\nBuilding dependency tree...\nReading state information...\nCalculating upgrade...\n0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.\n",
    "stdout_lines": [
        "Reading package lists...",
        "Building dependency tree...",
        "Reading state information...",
        "Calculating upgrade...",
        "0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded."
    ]
}
vagrant@controller:/vagrant/simple-commands$ ansible all -m apt -a "upgrade=yes" --become --verbose
Using /vagrant/simple-commands/ansible.cfg as config file
node-1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "msg": "Reading package lists...\nBuilding dependency tree...\nReading state information...\nCalculating upgrade...\n0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.\n",
    "stderr": "",
    "stderr_lines": [],
    "stdout": "Reading package lists...\nBuilding dependency tree...\nReading state information...\nCalculating upgrade...\n0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.\n",
    "stdout_lines": [
        "Reading package lists...",
        "Building dependency tree...",
        "Reading state information...",
        "Calculating upgrade...",
        "0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded."
    ]
}
node-2 | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "msg": "'/usr/bin/apt-get upgrade --with-new-pkgs ' failed: E: Failed to fetch http://de.ports.ubuntu.com/ubuntu-ports/pool/main/u/update-notifier/update-notifier-common_3.192.45.1_all.deb  Temporary failure resolving 'de.ports.ubuntu.com'\nE: Failed to fetch http://de.ports.ubuntu.com/ubuntu-ports/pool/main/o/openssl/libssl1.1_1.1.1l-1ubuntu1.1_arm64.deb  Temporary failure resolving 'de.ports.ubuntu.com'\nE: Failed to fetch http://de.ports.ubuntu.com/ubuntu-ports/pool/main/n/netplan.io/libnetplan0_0.103-0ubuntu7.2_arm64.deb  Temporary failure resolving 'de.ports.ubuntu.com'\nE: Failed to fetch http://de.ports.ubuntu.com/ubuntu-ports/pool/main/n/netplan.io/netplan.io_0.103-0ubuntu7.2_arm64.deb  Temporary failure resolving 'de.ports.ubuntu.com'\nE: Failed to fetch http://de.ports.ubuntu.com/ubuntu-ports/pool/main/o/openssl/openssl_1.1.1l-1ubuntu1.1_arm64.deb  Temporary failure resolving 'de.ports.ubuntu.com'\nE: Failed to fetch http://de.ports.ubuntu.com/ubuntu-ports/pool/main/u/ubuntu-advantage-tools/ubuntu-advantage-tools_27.5%7e21.10.1_arm64.deb  Temporary failure resolving 'de.ports.ubuntu.com'\nE: Failed to fetch http://de.ports.ubuntu.com/ubuntu-ports/pool/main/o/openssh/openssh-sftp-server_8.4p1-6ubuntu2.1_arm64.deb  Temporary failure resolving 'de.ports.ubuntu.com'\nE: Failed to fetch http://de.ports.ubuntu.com/ubuntu-ports/pool/main/o/openssh/openssh-server_8.4p1-6ubuntu2.1_arm64.deb  Temporary failure resolving 'de.ports.ubuntu.com'\nE: Failed to fetch http://de.ports.ubuntu.com/ubuntu-ports/pool/main/o/openssh/openssh-client_8.4p1-6ubuntu2.1_arm64.deb  Temporary failure resolving 'de.ports.ubuntu.com'\nE: Failed to fetch http://de.ports.ubuntu.com/ubuntu-ports/pool/main/l/linux-firmware/linux-firmware_1.201.3_all.deb  Temporary failure resolving 'de.ports.ubuntu.com'\nE: Unable to fetch some archives, maybe run apt-get update or try with --fix-missing?\n",
    "rc": 100,
    "stdout": "Reading package lists...\nBuilding dependency tree...\nReading state information...\nCalculating upgrade...\nThe following NEW packages will be installed:\n  linux-headers-5.13.0-25 linux-headers-5.13.0-25-generic\n  linux-image-5.13.0-25-generic linux-modules-5.13.0-25-generic\n  linux-modules-extra-5.13.0-25-generic\nThe following packages will be upgraded:\n  busybox-initramfs busybox-static libnetplan0 libnss-systemd libnss3\n  libpam-systemd libssl1.1 libsystemd0 libudev1 linux-firmware linux-generic\n  linux-headers-generic linux-image-generic netplan.io openssh-client\n  openssh-server openssh-sftp-server openssl systemd systemd-sysv\n  systemd-timesyncd ubuntu-advantage-tools udev update-notifier-common vim\n  vim-common vim-runtime vim-tiny xxd\n29 upgraded, 5 newly installed, 0 to remove and 0 not upgraded.\n19 standard security updates\nNeed to get 203 MB/330 MB of archives.\nAfter this operation, 559 MB of additional disk space will be used.\nIgn:1 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 update-notifier-common all 3.192.45.1\nIgn:2 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libssl1.1 arm64 1.1.1l-1ubuntu1.1\nIgn:3 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libnetplan0 arm64 0.103-0ubuntu7.2\nIgn:4 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 netplan.io arm64 0.103-0ubuntu7.2\nIgn:5 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssl arm64 1.1.1l-1ubuntu1.1\nIgn:6 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 ubuntu-advantage-tools arm64 27.5~21.10.1\nIgn:7 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-sftp-server arm64 1:8.4p1-6ubuntu2.1\nIgn:8 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-server arm64 1:8.4p1-6ubuntu2.1\nIgn:9 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-client arm64 1:8.4p1-6ubuntu2.1\nIgn:10 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 linux-firmware all 1.201.3\nIgn:1 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 update-notifier-common all 3.192.45.1\nIgn:2 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libssl1.1 arm64 1.1.1l-1ubuntu1.1\nIgn:3 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libnetplan0 arm64 0.103-0ubuntu7.2\nIgn:4 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 netplan.io arm64 0.103-0ubuntu7.2\nIgn:5 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssl arm64 1.1.1l-1ubuntu1.1\nIgn:6 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 ubuntu-advantage-tools arm64 27.5~21.10.1\nIgn:7 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-sftp-server arm64 1:8.4p1-6ubuntu2.1\nIgn:8 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-server arm64 1:8.4p1-6ubuntu2.1\nIgn:9 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-client arm64 1:8.4p1-6ubuntu2.1\nIgn:10 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 linux-firmware all 1.201.3\nIgn:1 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 update-notifier-common all 3.192.45.1\nIgn:2 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libssl1.1 arm64 1.1.1l-1ubuntu1.1\nIgn:3 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libnetplan0 arm64 0.103-0ubuntu7.2\nIgn:4 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 netplan.io arm64 0.103-0ubuntu7.2\nIgn:5 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssl arm64 1.1.1l-1ubuntu1.1\nIgn:6 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 ubuntu-advantage-tools arm64 27.5~21.10.1\nIgn:7 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-sftp-server arm64 1:8.4p1-6ubuntu2.1\nIgn:8 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-server arm64 1:8.4p1-6ubuntu2.1\nIgn:9 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-client arm64 1:8.4p1-6ubuntu2.1\nIgn:10 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 linux-firmware all 1.201.3\nErr:1 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 update-notifier-common all 3.192.45.1\n  Temporary failure resolving 'de.ports.ubuntu.com'\nErr:2 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libssl1.1 arm64 1.1.1l-1ubuntu1.1\n  Temporary failure resolving 'de.ports.ubuntu.com'\nErr:3 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libnetplan0 arm64 0.103-0ubuntu7.2\n  Temporary failure resolving 'de.ports.ubuntu.com'\nErr:4 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 netplan.io arm64 0.103-0ubuntu7.2\n  Temporary failure resolving 'de.ports.ubuntu.com'\nErr:5 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssl arm64 1.1.1l-1ubuntu1.1\n  Temporary failure resolving 'de.ports.ubuntu.com'\nErr:6 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 ubuntu-advantage-tools arm64 27.5~21.10.1\n  Temporary failure resolving 'de.ports.ubuntu.com'\nErr:7 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-sftp-server arm64 1:8.4p1-6ubuntu2.1\n  Temporary failure resolving 'de.ports.ubuntu.com'\nErr:8 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-server arm64 1:8.4p1-6ubuntu2.1\n  Temporary failure resolving 'de.ports.ubuntu.com'\nErr:9 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-client arm64 1:8.4p1-6ubuntu2.1\n  Temporary failure resolving 'de.ports.ubuntu.com'\nErr:10 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 linux-firmware all 1.201.3\n  Temporary failure resolving 'de.ports.ubuntu.com'\n",
    "stdout_lines": [
        "Reading package lists...",
        "Building dependency tree...",
        "Reading state information...",
        "Calculating upgrade...",
        "The following NEW packages will be installed:",
        "  linux-headers-5.13.0-25 linux-headers-5.13.0-25-generic",
        "  linux-image-5.13.0-25-generic linux-modules-5.13.0-25-generic",
        "  linux-modules-extra-5.13.0-25-generic",
        "The following packages will be upgraded:",
        "  busybox-initramfs busybox-static libnetplan0 libnss-systemd libnss3",
        "  libpam-systemd libssl1.1 libsystemd0 libudev1 linux-firmware linux-generic",
        "  linux-headers-generic linux-image-generic netplan.io openssh-client",
        "  openssh-server openssh-sftp-server openssl systemd systemd-sysv",
        "  systemd-timesyncd ubuntu-advantage-tools udev update-notifier-common vim",
        "  vim-common vim-runtime vim-tiny xxd",
        "29 upgraded, 5 newly installed, 0 to remove and 0 not upgraded.",
        "19 standard security updates",
        "Need to get 203 MB/330 MB of archives.",
        "After this operation, 559 MB of additional disk space will be used.",
        "Ign:1 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 update-notifier-common all 3.192.45.1",
        "Ign:2 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libssl1.1 arm64 1.1.1l-1ubuntu1.1",
        "Ign:3 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libnetplan0 arm64 0.103-0ubuntu7.2",
        "Ign:4 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 netplan.io arm64 0.103-0ubuntu7.2",
        "Ign:5 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssl arm64 1.1.1l-1ubuntu1.1",
        "Ign:6 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 ubuntu-advantage-tools arm64 27.5~21.10.1",
        "Ign:7 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-sftp-server arm64 1:8.4p1-6ubuntu2.1",
        "Ign:8 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-server arm64 1:8.4p1-6ubuntu2.1",
        "Ign:9 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-client arm64 1:8.4p1-6ubuntu2.1",
        "Ign:10 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 linux-firmware all 1.201.3",
        "Ign:1 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 update-notifier-common all 3.192.45.1",
        "Ign:2 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libssl1.1 arm64 1.1.1l-1ubuntu1.1",
        "Ign:3 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libnetplan0 arm64 0.103-0ubuntu7.2",
        "Ign:4 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 netplan.io arm64 0.103-0ubuntu7.2",
        "Ign:5 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssl arm64 1.1.1l-1ubuntu1.1",
        "Ign:6 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 ubuntu-advantage-tools arm64 27.5~21.10.1",
        "Ign:7 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-sftp-server arm64 1:8.4p1-6ubuntu2.1",
        "Ign:8 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-server arm64 1:8.4p1-6ubuntu2.1",
        "Ign:9 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-client arm64 1:8.4p1-6ubuntu2.1",
        "Ign:10 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 linux-firmware all 1.201.3",
        "Ign:1 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 update-notifier-common all 3.192.45.1",
        "Ign:2 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libssl1.1 arm64 1.1.1l-1ubuntu1.1",
        "Ign:3 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libnetplan0 arm64 0.103-0ubuntu7.2",
        "Ign:4 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 netplan.io arm64 0.103-0ubuntu7.2",
        "Ign:5 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssl arm64 1.1.1l-1ubuntu1.1",
        "Ign:6 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 ubuntu-advantage-tools arm64 27.5~21.10.1",
        "Ign:7 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-sftp-server arm64 1:8.4p1-6ubuntu2.1",
        "Ign:8 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-server arm64 1:8.4p1-6ubuntu2.1",
        "Ign:9 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-client arm64 1:8.4p1-6ubuntu2.1",
        "Ign:10 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 linux-firmware all 1.201.3",
        "Err:1 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 update-notifier-common all 3.192.45.1",
        "  Temporary failure resolving 'de.ports.ubuntu.com'",
        "Err:2 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libssl1.1 arm64 1.1.1l-1ubuntu1.1",
        "  Temporary failure resolving 'de.ports.ubuntu.com'",
        "Err:3 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 libnetplan0 arm64 0.103-0ubuntu7.2",
        "  Temporary failure resolving 'de.ports.ubuntu.com'",
        "Err:4 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 netplan.io arm64 0.103-0ubuntu7.2",
        "  Temporary failure resolving 'de.ports.ubuntu.com'",
        "Err:5 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssl arm64 1.1.1l-1ubuntu1.1",
        "  Temporary failure resolving 'de.ports.ubuntu.com'",
        "Err:6 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 ubuntu-advantage-tools arm64 27.5~21.10.1",
        "  Temporary failure resolving 'de.ports.ubuntu.com'",
        "Err:7 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-sftp-server arm64 1:8.4p1-6ubuntu2.1",
        "  Temporary failure resolving 'de.ports.ubuntu.com'",
        "Err:8 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-server arm64 1:8.4p1-6ubuntu2.1",
        "  Temporary failure resolving 'de.ports.ubuntu.com'",
        "Err:9 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 openssh-client arm64 1:8.4p1-6ubuntu2.1",
        "  Temporary failure resolving 'de.ports.ubuntu.com'",
        "Err:10 http://de.ports.ubuntu.com/ubuntu-ports impish-updates/main arm64 linux-firmware all 1.201.3",
        "  Temporary failure resolving 'de.ports.ubuntu.com'"
    ]
}
vagrant@controller:/vagrant/simple-commands$ 
```

