# Managing services

Managing services

Application(s) that are background processes that are waiting to fulfill a task

Start, stop, reload. Background daemon processes.

Say, setup MongoDB. Development environment.

Some of the commands are long.

These commands are based from https://wiki.crowncloud.net/?How_to_Install_MongoDB_5_on_Ubuntu_21_10

Add APT key

```
ansible dbservers -m apt_key -a "url=https://www.mongodb.org/static/pgp/server-5.0.asc keyring=/etc/apt/trusted.gpg.d/debian.gpg state=present" --become
node-2 | CHANGED => {
    "after": [
        "B00A0BD1E2C63C11"
    ],
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "before": [],
    "changed": true,
    "fp": "B00A0BD1E2C63C11",
    "id": "B00A0BD1E2C63C11",
    "key_id": "B00A0BD1E2C63C11",
    "short_id": "E2C63C11"
}
```

Adding repository

```
vagrant@controller:/vagrant/5-managing-services$ ansible dbservers -m apt_repository -a "repo='deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse' state=present" --become
node-2 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "repo": "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse",
    "state": "present"
}
vagrant@controller:/vagrant/5-managing-services$ ansible dbservers -m apt_repository -a "repo='deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse' state=present" --become
node-2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "repo": "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse",
    "state": "present"
}
```

Installing Mongodb

```
vagrant@controller:/vagrant/5-managing-services$ ansible dbservers -m apt -a "name=mongodb-org state=present" --become
# takes a long time ...
vagrant@controller:/vagrant/5-managing-services$ ansible dbservers -m apt -a "name=mongodb-org state=present" --become -vvv
ansible [core 2.12.1]
  config file = /vagrant/5-managing-services/ansible.cfg
  configured module search path = ['/home/vagrant/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/vagrant/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.9.7 (default, Sep 10 2021, 14:59:43) [GCC 11.2.0]
  jinja version = 2.11.3
  libyaml = True
Using /vagrant/5-managing-services/ansible.cfg as config file
host_list declined parsing /vagrant/5-managing-services/hosts as it did not pass its verify_file() method
script declined parsing /vagrant/5-managing-services/hosts as it did not pass its verify_file() method
auto declined parsing /vagrant/5-managing-services/hosts as it did not pass its verify_file() method
Parsed /vagrant/5-managing-services/hosts inventory source with ini plugin
Skipping callback 'default', as we already have a stdout callback.
Skipping callback 'minimal', as we already have a stdout callback.
Skipping callback 'oneline', as we already have a stdout callback.
META: ran handlers
<node-2> ESTABLISH SSH CONNECTION FOR USER: None
<node-2> SSH: EXEC ssh -C -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/vagrant/.ansible/cp/8f85d6dfbf node-2 '/bin/sh -c '"'"'echo ~ && sleep 0'"'"''
<node-2> (0, b'/home/vagrant\n', b'')
<node-2> ESTABLISH SSH CONNECTION FOR USER: None
<node-2> SSH: EXEC ssh -C -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/vagrant/.ansible/cp/8f85d6dfbf node-2 '/bin/sh -c '"'"'( umask 77 && mkdir -p "` echo /home/vagrant/.ansible/tmp `"&& mkdir "` echo /home/vagrant/.ansible/tmp/ansible-tmp-1642253834.4589152-1918-11557177972227 `" && echo ansible-tmp-1642253834.4589152-1918-11557177972227="` echo /home/vagrant/.ansible/tmp/ansible-tmp-1642253834.4589152-1918-11557177972227 `" ) && sleep 0'"'"''
<node-2> (0, b'ansible-tmp-1642253834.4589152-1918-11557177972227=/home/vagrant/.ansible/tmp/ansible-tmp-1642253834.4589152-1918-11557177972227\n', b'')
<node-2> Attempting python interpreter discovery
<node-2> ESTABLISH SSH CONNECTION FOR USER: None
<node-2> SSH: EXEC ssh -C -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/vagrant/.ansible/cp/8f85d6dfbf node-2 '/bin/sh -c '"'"'echo PLATFORM; uname; echo FOUND; command -v '"'"'"'"'"'"'"'"'python3.10'"'"'"'"'"'"'"'"'; command -v '"'"'"'"'"'"'"'"'python3.9'"'"'"'"'"'"'"'"'; command -v '"'"'"'"'"'"'"'"'python3.8'"'"'"'"'"'"'"'"'; command -v '"'"'"'"'"'"'"'"'python3.7'"'"'"'"'"'"'"'"'; command -v '"'"'"'"'"'"'"'"'python3.6'"'"'"'"'"'"'"'"'; command -v '"'"'"'"'"'"'"'"'python3.5'"'"'"'"'"'"'"'"'; command -v '"'"'"'"'"'"'"'"'/usr/bin/python3'"'"'"'"'"'"'"'"'; command -v '"'"'"'"'"'"'"'"'/usr/libexec/platform-python'"'"'"'"'"'"'"'"'; command -v '"'"'"'"'"'"'"'"'python2.7'"'"'"'"'"'"'"'"'; command -v '"'"'"'"'"'"'"'"'python2.6'"'"'"'"'"'"'"'"'; command -v '"'"'"'"'"'"'"'"'/usr/bin/python'"'"'"'"'"'"'"'"'; command -v '"'"'"'"'"'"'"'"'python'"'"'"'"'"'"'"'"'; echo ENDFOUND && sleep 0'"'"''
<node-2> (0, b'PLATFORM\nLinux\nFOUND\n/usr/bin/python3.9\n/usr/bin/python3\nENDFOUND\n', b'')
<node-2> ESTABLISH SSH CONNECTION FOR USER: None
<node-2> SSH: EXEC ssh -C -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/vagrant/.ansible/cp/8f85d6dfbf node-2 '/bin/sh -c '"'"'/usr/bin/python3.9 && sleep 0'"'"''
<node-2> (0, b'{"platform_dist_result": [], "osrelease_content": "PRETTY_NAME=\\"Ubuntu 21.10\\"\\nNAME=\\"Ubuntu\\"\\nVERSION_ID=\\"21.10\\"\\nVERSION=\\"21.10 (Impish Indri)\\"\\nVERSION_CODENAME=impish\\nID=ubuntu\\nID_LIKE=debian\\nHOME_URL=\\"https://www.ubuntu.com/\\"\\nSUPPORT_URL=\\"https://help.ubuntu.com/\\"\\nBUG_REPORT_URL=\\"https://bugs.launchpad.net/ubuntu/\\"\\nPRIVACY_POLICY_URL=\\"https://www.ubuntu.com/legal/terms-and-policies/privacy-policy\\"\\nUBUNTU_CODENAME=impish\\n"}\n', b'')
Using module file /usr/lib/python3/dist-packages/ansible/modules/apt.py
<node-2> PUT /home/vagrant/.ansible/tmp/ansible-local-1915ftw6x3c5/tmpg7jw1e1x TO /home/vagrant/.ansible/tmp/ansible-tmp-1642253834.4589152-1918-11557177972227/AnsiballZ_apt.py
<node-2> SSH: EXEC sftp -b - -C -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/vagrant/.ansible/cp/8f85d6dfbf '[node-2]'
<node-2> (0, b'sftp> put /home/vagrant/.ansible/tmp/ansible-local-1915ftw6x3c5/tmpg7jw1e1x /home/vagrant/.ansible/tmp/ansible-tmp-1642253834.4589152-1918-11557177972227/AnsiballZ_apt.py\n', b'')
<node-2> ESTABLISH SSH CONNECTION FOR USER: None
<node-2> SSH: EXEC ssh -C -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/vagrant/.ansible/cp/8f85d6dfbf node-2 '/bin/sh -c '"'"'chmod u+x /home/vagrant/.ansible/tmp/ansible-tmp-1642253834.4589152-1918-11557177972227/ /home/vagrant/.ansible/tmp/ansible-tmp-1642253834.4589152-1918-11557177972227/AnsiballZ_apt.py && sleep 0'"'"''
<node-2> (0, b'', b'')
<node-2> ESTABLISH SSH CONNECTION FOR USER: None
<node-2> SSH: EXEC ssh -C -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/vagrant/.ansible/cp/8f85d6dfbf -tt node-2 '/bin/sh -c '"'"'sudo -H -S -n  -u root /bin/sh -c '"'"'"'"'"'"'"'"'echo BECOME-SUCCESS-cbfwfdggyfhxhstvsrqyelemmvdxdits ; /usr/bin/python3 /home/vagrant/.ansible/tmp/ansible-tmp-1642253834.4589152-1918-11557177972227/AnsiballZ_apt.py'"'"'"'"'"'"'"'"' && sleep 0'"'"''
Escalation succeeded
<node-2> (0, b'\r\n{"changed": true, "stdout": "Reading package lists...\\nBuilding dependency tree...\\nReading state information...\\nThe following additional packages will be installed:\\n  mongodb-database-tools mongodb-mongosh mongodb-org-database\\n  mongodb-org-database-tools-extra mongodb-org-mongos mongodb-org-server\\n  mongodb-org-shell mongodb-org-tools\\nThe following NEW packages will be installed:\\n  mongodb-database-tools mongodb-mongosh mongodb-org mongodb-org-database\\n  mongodb-org-database-tools-extra mongodb-org-mongos mongodb-org-server\\n  mongodb-org-shell mongodb-org-tools\\n0 upgraded, 9 newly installed, 0 to remove and 29 not upgraded.\\nNeed to get 54.3 MB/135 MB of archives.\\nAfter this operation, 442 MB of additional disk space will be used.\\nGet:1 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-mongosh arm64 1.1.8 [37.9 MB]\\nGet:2 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org-mongos arm64 5.0.5 [16.4 MB]\\nGet:3 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org-database-tools-extra arm64 5.0.5 [7,752 B]\\nGet:4 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org-database arm64 5.0.5 [3,540 B]\\nGet:5 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org-tools arm64 5.0.5 [2,892 B]\\nGet:6 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org arm64 5.0.5 [2,932 B]\\nFetched 52.0 MB in 2min 11s (396 kB/s)\\nSelecting previously unselected package mongodb-database-tools.\\r\\n(Reading database ... \\r(Reading database ... 5%\\r(Reading database ... 10%\\r(Reading database ... 15%\\r(Reading database ... 20%\\r(Reading database ... 25%\\r(Reading database ... 30%\\r(Reading database ... 35%\\r(Reading database ... 40%\\r(Reading database ... 45%\\r(Reading database ... 50%\\r(Reading database ... 55%\\r(Reading database ... 60%\\r(Reading database ... 65%\\r(Reading database ... 70%\\r(Reading database ... 75%\\r(Reading database ... 80%\\r(Reading database ... 85%\\r(Reading database ... 90%\\r(Reading database ... 95%\\r(Reading database ... 100%\\r(Reading database ... 75141 files and directories currently installed.)\\r\\nPreparing to unpack .../0-mongodb-database-tools_100.5.1_arm64.deb ...\\r\\nUnpacking mongodb-database-tools (100.5.1) ...\\r\\nSelecting previously unselected package mongodb-mongosh.\\r\\nPreparing to unpack .../1-mongodb-mongosh_1.1.8_arm64.deb ...\\r\\nUnpacking mongodb-mongosh (1.1.8) ...\\r\\nSelecting previously unselected package mongodb-org-shell.\\r\\nPreparing to unpack .../2-mongodb-org-shell_5.0.5_arm64.deb ...\\r\\nUnpacking mongodb-org-shell (5.0.5) ...\\r\\nSelecting previously unselected package mongodb-org-server.\\r\\nPreparing to unpack .../3-mongodb-org-server_5.0.5_arm64.deb ...\\r\\nUnpacking mongodb-org-server (5.0.5) ...\\r\\nSelecting previously unselected package mongodb-org-mongos.\\r\\nPreparing to unpack .../4-mongodb-org-mongos_5.0.5_arm64.deb ...\\r\\nUnpacking mongodb-org-mongos (5.0.5) ...\\r\\nSelecting previously unselected package mongodb-org-database-tools-extra.\\r\\nPreparing to unpack .../5-mongodb-org-database-tools-extra_5.0.5_arm64.deb ...\\r\\nUnpacking mongodb-org-database-tools-extra (5.0.5) ...\\r\\nSelecting previously unselected package mongodb-org-database.\\r\\nPreparing to unpack .../6-mongodb-org-database_5.0.5_arm64.deb ...\\r\\nUnpacking mongodb-org-database (5.0.5) ...\\r\\nSelecting previously unselected package mongodb-org-tools.\\r\\nPreparing to unpack .../7-mongodb-org-tools_5.0.5_arm64.deb ...\\r\\nUnpacking mongodb-org-tools (5.0.5) ...\\r\\nSelecting previously unselected package mongodb-org.\\r\\nPreparing to unpack .../8-mongodb-org_5.0.5_arm64.deb ...\\r\\nUnpacking mongodb-org (5.0.5) ...\\r\\nSetting up mongodb-mongosh (1.1.8) ...\\r\\nSetting up mongodb-org-server (5.0.5) ...\\r\\nAdding system user `mongodb\' (UID 112) ...\\r\\nAdding new user `mongodb\' (UID 112) with group `nogroup\' ...\\r\\nNot creating home directory `/home/mongodb\'.\\r\\nAdding group `mongodb\' (GID 119) ...\\r\\nDone.\\r\\nAdding user `mongodb\' to group `mongodb\' ...\\r\\nAdding user mongodb to group mongodb\\r\\nDone.\\r\\nSetting up mongodb-org-shell (5.0.5) ...\\r\\nSetting up mongodb-database-tools (100.5.1) ...\\r\\nSetting up mongodb-org-mongos (5.0.5) ...\\r\\nSetting up mongodb-org-database-tools-extra (5.0.5) ...\\r\\nSetting up mongodb-org-database (5.0.5) ...\\r\\nSetting up mongodb-org-tools (5.0.5) ...\\r\\nSetting up mongodb-org (5.0.5) ...\\r\\nProcessing triggers for man-db (2.9.4-2) ...\\r\\nNEEDRESTART-VER: 3.5\\nNEEDRESTART-KCUR: 5.13.0-21-generic\\nNEEDRESTART-KEXP: 5.13.0-21-generic\\nNEEDRESTART-KSTA: 1\\n", "stderr": "", "diff": {}, "cache_updated": false, "cache_update_time": 1642253795, "invocation": {"module_args": {"name": "mongodb-org", "state": "present", "package": ["mongodb-org"], "update_cache_retries": 5, "update_cache_retry_max_delay": 12, "cache_valid_time": 0, "purge": false, "force": false, "upgrade": null, "dpkg_options": "force-confdef,force-confold", "autoremove": false, "autoclean": false, "fail_on_autoremove": false, "only_upgrade": false, "force_apt_get": false, "allow_unauthenticated": false, "allow_downgrade": false, "lock_timeout": 60, "update_cache": null, "deb": null, "default_release": null, "install_recommends": null, "policy_rc_d": null}}}\r\n', b'Shared connection to node-2 closed.\r\n')
<node-2> ESTABLISH SSH CONNECTION FOR USER: None
<node-2> SSH: EXEC ssh -C -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/vagrant/.ansible/cp/8f85d6dfbf node-2 '/bin/sh -c '"'"'rm -f -r /home/vagrant/.ansible/tmp/ansible-tmp-1642253834.4589152-1918-11557177972227/ > /dev/null 2>&1 && sleep 0'"'"''
<node-2> (0, b'', b'')
node-2 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "cache_update_time": 1642253795,
    "cache_updated": false,
    "changed": true,
    "diff": {},
    "invocation": {
        "module_args": {
            "allow_downgrade": false,
            "allow_unauthenticated": false,
            "autoclean": false,
            "autoremove": false,
            "cache_valid_time": 0,
            "deb": null,
            "default_release": null,
            "dpkg_options": "force-confdef,force-confold",
            "fail_on_autoremove": false,
            "force": false,
            "force_apt_get": false,
            "install_recommends": null,
            "lock_timeout": 60,
            "name": "mongodb-org",
            "only_upgrade": false,
            "package": [
                "mongodb-org"
            ],
            "policy_rc_d": null,
            "purge": false,
            "state": "present",
            "update_cache": null,
            "update_cache_retries": 5,
            "update_cache_retry_max_delay": 12,
            "upgrade": null
        }
    },
    "stderr": "",
    "stderr_lines": [],
    "stdout": "Reading package lists...\nBuilding dependency tree...\nReading state information...\nThe following additional packages will be installed:\n  mongodb-database-tools mongodb-mongosh mongodb-org-database\n  mongodb-org-database-tools-extra mongodb-org-mongos mongodb-org-server\n  mongodb-org-shell mongodb-org-tools\nThe following NEW packages will be installed:\n  mongodb-database-tools mongodb-mongosh mongodb-org mongodb-org-database\n  mongodb-org-database-tools-extra mongodb-org-mongos mongodb-org-server\n  mongodb-org-shell mongodb-org-tools\n0 upgraded, 9 newly installed, 0 to remove and 29 not upgraded.\nNeed to get 54.3 MB/135 MB of archives.\nAfter this operation, 442 MB of additional disk space will be used.\nGet:1 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-mongosh arm64 1.1.8 [37.9 MB]\nGet:2 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org-mongos arm64 5.0.5 [16.4 MB]\nGet:3 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org-database-tools-extra arm64 5.0.5 [7,752 B]\nGet:4 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org-database arm64 5.0.5 [3,540 B]\nGet:5 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org-tools arm64 5.0.5 [2,892 B]\nGet:6 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org arm64 5.0.5 [2,932 B]\nFetched 52.0 MB in 2min 11s (396 kB/s)\nSelecting previously unselected package mongodb-database-tools.\r\n(Reading database ... \r(Reading database ... 5%\r(Reading database ... 10%\r(Reading database ... 15%\r(Reading database ... 20%\r(Reading database ... 25%\r(Reading database ... 30%\r(Reading database ... 35%\r(Reading database ... 40%\r(Reading database ... 45%\r(Reading database ... 50%\r(Reading database ... 55%\r(Reading database ... 60%\r(Reading database ... 65%\r(Reading database ... 70%\r(Reading database ... 75%\r(Reading database ... 80%\r(Reading database ... 85%\r(Reading database ... 90%\r(Reading database ... 95%\r(Reading database ... 100%\r(Reading database ... 75141 files and directories currently installed.)\r\nPreparing to unpack .../0-mongodb-database-tools_100.5.1_arm64.deb ...\r\nUnpacking mongodb-database-tools (100.5.1) ...\r\nSelecting previously unselected package mongodb-mongosh.\r\nPreparing to unpack .../1-mongodb-mongosh_1.1.8_arm64.deb ...\r\nUnpacking mongodb-mongosh (1.1.8) ...\r\nSelecting previously unselected package mongodb-org-shell.\r\nPreparing to unpack .../2-mongodb-org-shell_5.0.5_arm64.deb ...\r\nUnpacking mongodb-org-shell (5.0.5) ...\r\nSelecting previously unselected package mongodb-org-server.\r\nPreparing to unpack .../3-mongodb-org-server_5.0.5_arm64.deb ...\r\nUnpacking mongodb-org-server (5.0.5) ...\r\nSelecting previously unselected package mongodb-org-mongos.\r\nPreparing to unpack .../4-mongodb-org-mongos_5.0.5_arm64.deb ...\r\nUnpacking mongodb-org-mongos (5.0.5) ...\r\nSelecting previously unselected package mongodb-org-database-tools-extra.\r\nPreparing to unpack .../5-mongodb-org-database-tools-extra_5.0.5_arm64.deb ...\r\nUnpacking mongodb-org-database-tools-extra (5.0.5) ...\r\nSelecting previously unselected package mongodb-org-database.\r\nPreparing to unpack .../6-mongodb-org-database_5.0.5_arm64.deb ...\r\nUnpacking mongodb-org-database (5.0.5) ...\r\nSelecting previously unselected package mongodb-org-tools.\r\nPreparing to unpack .../7-mongodb-org-tools_5.0.5_arm64.deb ...\r\nUnpacking mongodb-org-tools (5.0.5) ...\r\nSelecting previously unselected package mongodb-org.\r\nPreparing to unpack .../8-mongodb-org_5.0.5_arm64.deb ...\r\nUnpacking mongodb-org (5.0.5) ...\r\nSetting up mongodb-mongosh (1.1.8) ...\r\nSetting up mongodb-org-server (5.0.5) ...\r\nAdding system user `mongodb' (UID 112) ...\r\nAdding new user `mongodb' (UID 112) with group `nogroup' ...\r\nNot creating home directory `/home/mongodb'.\r\nAdding group `mongodb' (GID 119) ...\r\nDone.\r\nAdding user `mongodb' to group `mongodb' ...\r\nAdding user mongodb to group mongodb\r\nDone.\r\nSetting up mongodb-org-shell (5.0.5) ...\r\nSetting up mongodb-database-tools (100.5.1) ...\r\nSetting up mongodb-org-mongos (5.0.5) ...\r\nSetting up mongodb-org-database-tools-extra (5.0.5) ...\r\nSetting up mongodb-org-database (5.0.5) ...\r\nSetting up mongodb-org-tools (5.0.5) ...\r\nSetting up mongodb-org (5.0.5) ...\r\nProcessing triggers for man-db (2.9.4-2) ...\r\nNEEDRESTART-VER: 3.5\nNEEDRESTART-KCUR: 5.13.0-21-generic\nNEEDRESTART-KEXP: 5.13.0-21-generic\nNEEDRESTART-KSTA: 1\n",
    "stdout_lines": [
        "Reading package lists...",
        "Building dependency tree...",
        "Reading state information...",
        "The following additional packages will be installed:",
        "  mongodb-database-tools mongodb-mongosh mongodb-org-database",
        "  mongodb-org-database-tools-extra mongodb-org-mongos mongodb-org-server",
        "  mongodb-org-shell mongodb-org-tools",
        "The following NEW packages will be installed:",
        "  mongodb-database-tools mongodb-mongosh mongodb-org mongodb-org-database",
        "  mongodb-org-database-tools-extra mongodb-org-mongos mongodb-org-server",
        "  mongodb-org-shell mongodb-org-tools",
        "0 upgraded, 9 newly installed, 0 to remove and 29 not upgraded.",
        "Need to get 54.3 MB/135 MB of archives.",
        "After this operation, 442 MB of additional disk space will be used.",
        "Get:1 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-mongosh arm64 1.1.8 [37.9 MB]",
        "Get:2 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org-mongos arm64 5.0.5 [16.4 MB]",
        "Get:3 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org-database-tools-extra arm64 5.0.5 [7,752 B]",
        "Get:4 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org-database arm64 5.0.5 [3,540 B]",
        "Get:5 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org-tools arm64 5.0.5 [2,892 B]",
        "Get:6 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0/multiverse arm64 mongodb-org arm64 5.0.5 [2,932 B]",
        "Fetched 52.0 MB in 2min 11s (396 kB/s)",
        "Selecting previously unselected package mongodb-database-tools.",
        "(Reading database ... ",
        "(Reading database ... 5%",
        "(Reading database ... 10%",
        "(Reading database ... 15%",
        "(Reading database ... 20%",
        "(Reading database ... 25%",
        "(Reading database ... 30%",
        "(Reading database ... 35%",
        "(Reading database ... 40%",
        "(Reading database ... 45%",
        "(Reading database ... 50%",
        "(Reading database ... 55%",
        "(Reading database ... 60%",
        "(Reading database ... 65%",
        "(Reading database ... 70%",
        "(Reading database ... 75%",
        "(Reading database ... 80%",
        "(Reading database ... 85%",
        "(Reading database ... 90%",
        "(Reading database ... 95%",
        "(Reading database ... 100%",
        "(Reading database ... 75141 files and directories currently installed.)",
        "Preparing to unpack .../0-mongodb-database-tools_100.5.1_arm64.deb ...",
        "Unpacking mongodb-database-tools (100.5.1) ...",
        "Selecting previously unselected package mongodb-mongosh.",
        "Preparing to unpack .../1-mongodb-mongosh_1.1.8_arm64.deb ...",
        "Unpacking mongodb-mongosh (1.1.8) ...",
        "Selecting previously unselected package mongodb-org-shell.",
        "Preparing to unpack .../2-mongodb-org-shell_5.0.5_arm64.deb ...",
        "Unpacking mongodb-org-shell (5.0.5) ...",
        "Selecting previously unselected package mongodb-org-server.",
        "Preparing to unpack .../3-mongodb-org-server_5.0.5_arm64.deb ...",
        "Unpacking mongodb-org-server (5.0.5) ...",
        "Selecting previously unselected package mongodb-org-mongos.",
        "Preparing to unpack .../4-mongodb-org-mongos_5.0.5_arm64.deb ...",
        "Unpacking mongodb-org-mongos (5.0.5) ...",
        "Selecting previously unselected package mongodb-org-database-tools-extra.",
        "Preparing to unpack .../5-mongodb-org-database-tools-extra_5.0.5_arm64.deb ...",
        "Unpacking mongodb-org-database-tools-extra (5.0.5) ...",
        "Selecting previously unselected package mongodb-org-database.",
        "Preparing to unpack .../6-mongodb-org-database_5.0.5_arm64.deb ...",
        "Unpacking mongodb-org-database (5.0.5) ...",
        "Selecting previously unselected package mongodb-org-tools.",
        "Preparing to unpack .../7-mongodb-org-tools_5.0.5_arm64.deb ...",
        "Unpacking mongodb-org-tools (5.0.5) ...",
        "Selecting previously unselected package mongodb-org.",
        "Preparing to unpack .../8-mongodb-org_5.0.5_arm64.deb ...",
        "Unpacking mongodb-org (5.0.5) ...",
        "Setting up mongodb-mongosh (1.1.8) ...",
        "Setting up mongodb-org-server (5.0.5) ...",
        "Adding system user `mongodb' (UID 112) ...",
        "Adding new user `mongodb' (UID 112) with group `nogroup' ...",
        "Not creating home directory `/home/mongodb'.",
        "Adding group `mongodb' (GID 119) ...",
        "Done.",
        "Adding user `mongodb' to group `mongodb' ...",
        "Adding user mongodb to group mongodb",
        "Done.",
        "Setting up mongodb-org-shell (5.0.5) ...",
        "Setting up mongodb-database-tools (100.5.1) ...",
        "Setting up mongodb-org-mongos (5.0.5) ...",
        "Setting up mongodb-org-database-tools-extra (5.0.5) ...",
        "Setting up mongodb-org-database (5.0.5) ...",
        "Setting up mongodb-org-tools (5.0.5) ...",
        "Setting up mongodb-org (5.0.5) ...",
        "Processing triggers for man-db (2.9.4-2) ...",
        "NEEDRESTART-VER: 3.5",
        "NEEDRESTART-KCUR: 5.13.0-21-generic",
        "NEEDRESTART-KEXP: 5.13.0-21-generic",
        "NEEDRESTART-KSTA: 1"
    ]
}
META: ran handlers
META: ran handlers
vagrant@controller:/vagrant/5-managing-services$
```

It is installed but not active

```
vagrant@node-2:~$ sudo service mongod status
○ mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; disabled; vendor preset: enabled)
     Active: inactive (dead)
       Docs: https://docs.mongodb.org/manual
vagrant@node-2:~$
```

https://docs.ansible.com/ansible/2.9/modules/service_module.html#service-module

Start service

```
vagrant@controller:/vagrant/5-managing-services$ ansible dbservers -m service -a "name=mongod state=started" --become
node-2 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "name": "mongod",
    "state": "started",
    "status": {
        "ActiveEnterTimestampMonotonic": "0",
        "ActiveExitTimestampMonotonic": "0",
        "ActiveState": "inactive",
        "After": "system.slice sysinit.target network-online.target systemd-journald.socket basic.target",
        "AllowIsolate": "no",
        "AssertResult": "no",
        "AssertTimestampMonotonic": "0",
        "Before": "shutdown.target",
        "BlockIOAccounting": "no",
        "BlockIOWeight": "[not set]",
        "CPUAccounting": "yes",
        "CPUAffinityFromNUMA": "no",
        "CPUQuotaPerSecUSec": "infinity",
        "CPUQuotaPeriodUSec": "infinity",
        "CPUSchedulingPolicy": "0",
        "CPUSchedulingPriority": "0",
        "CPUSchedulingResetOnFork": "no",
        "CPUShares": "[not set]",
        "CPUUsageNSec": "[not set]",
        "CPUWeight": "[not set]",
        "CacheDirectoryMode": "0755",
        "CanFreeze": "yes",
        "CanIsolate": "no",
        "CanReload": "no",
        "CanStart": "yes",
        "CanStop": "yes",
        "CapabilityBoundingSet": "cap_chown cap_dac_override cap_dac_read_search cap_fowner cap_fsetid cap_kill cap_setgid cap_setuid cap_setpcap cap_linux_immutable cap_net_bind_service cap_net_broadcast cap_net_admin cap_net_raw cap_ipc_lock cap_ipc_owner cap_sys_module cap_sys_rawio cap_sys_chroot cap_sys_ptrace cap_sys_pacct cap_sys_admin cap_sys_boot cap_sys_nice cap_sys_resource cap_sys_time cap_sys_tty_config cap_mknod cap_lease cap_audit_write cap_audit_control cap_setfcap cap_mac_override cap_mac_admin cap_syslog cap_wake_alarm cap_block_suspend cap_audit_read cap_perfmon cap_bpf cap_checkpoint_restore",
        "CleanResult": "success",
        "CollectMode": "inactive",
        "ConditionResult": "no",
        "ConditionTimestampMonotonic": "0",
        "ConfigurationDirectoryMode": "0755",
        "Conflicts": "shutdown.target",
        "ControlPID": "0",
        "CoredumpFilter": "0x33",
        "DefaultDependencies": "yes",
        "DefaultMemoryLow": "0",
        "DefaultMemoryMin": "0",
        "Delegate": "no",
        "Description": "MongoDB Database Server",
        "DevicePolicy": "auto",
        "Documentation": "https://docs.mongodb.org/manual",
        "DynamicUser": "no",
        "EnvironmentFiles": "/etc/default/mongod (ignore_errors=yes)",
        "ExecMainCode": "0",
        "ExecMainExitTimestampMonotonic": "0",
        "ExecMainPID": "0",
        "ExecMainStartTimestampMonotonic": "0",
        "ExecMainStatus": "0",
        "ExecStart": "{ path=/usr/bin/mongod ; argv[]=/usr/bin/mongod --config /etc/mongod.conf ; ignore_errors=no ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }",
        "ExecStartEx": "{ path=/usr/bin/mongod ; argv[]=/usr/bin/mongod --config /etc/mongod.conf ; flags= ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }",
        "FailureAction": "none",
        "FileDescriptorStoreMax": "0",
        "FinalKillSignal": "9",
        "FragmentPath": "/lib/systemd/system/mongod.service",
        "FreezerState": "running",
        "GID": "[not set]",
        "Group": "mongodb",
        "GuessMainPID": "yes",
        "IOAccounting": "no",
        "IOReadBytes": "18446744073709551615",
        "IOReadOperations": "18446744073709551615",
        "IOSchedulingClass": "0",
        "IOSchedulingPriority": "0",
        "IOWeight": "[not set]",
        "IOWriteBytes": "18446744073709551615",
        "IOWriteOperations": "18446744073709551615",
        "IPAccounting": "no",
        "IPEgressBytes": "[no data]",
        "IPEgressPackets": "[no data]",
        "IPIngressBytes": "[no data]",
        "IPIngressPackets": "[no data]",
        "Id": "mongod.service",
        "IgnoreOnIsolate": "no",
        "IgnoreSIGPIPE": "yes",
        "InactiveEnterTimestampMonotonic": "0",
        "InactiveExitTimestampMonotonic": "0",
        "JobRunningTimeoutUSec": "infinity",
        "JobTimeoutAction": "none",
        "JobTimeoutUSec": "infinity",
        "KeyringMode": "private",
        "KillMode": "control-group",
        "KillSignal": "15",
        "LimitAS": "infinity",
        "LimitASSoft": "infinity",
        "LimitCORE": "infinity",
        "LimitCORESoft": "0",
        "LimitCPU": "infinity",
        "LimitCPUSoft": "infinity",
        "LimitDATA": "infinity",
        "LimitDATASoft": "infinity",
        "LimitFSIZE": "infinity",
        "LimitFSIZESoft": "infinity",
        "LimitLOCKS": "infinity",
        "LimitLOCKSSoft": "infinity",
        "LimitMEMLOCK": "infinity",
        "LimitMEMLOCKSoft": "infinity",
        "LimitMSGQUEUE": "819200",
        "LimitMSGQUEUESoft": "819200",
        "LimitNICE": "0",
        "LimitNICESoft": "0",
        "LimitNOFILE": "64000",
        "LimitNOFILESoft": "64000",
        "LimitNPROC": "64000",
        "LimitNPROCSoft": "64000",
        "LimitRSS": "infinity",
        "LimitRSSSoft": "infinity",
        "LimitRTPRIO": "0",
        "LimitRTPRIOSoft": "0",
        "LimitRTTIME": "infinity",
        "LimitRTTIMESoft": "infinity",
        "LimitSIGPENDING": "1455",
        "LimitSIGPENDINGSoft": "1455",
        "LimitSTACK": "infinity",
        "LimitSTACKSoft": "8388608",
        "LoadState": "loaded",
        "LockPersonality": "no",
        "LogLevelMax": "-1",
        "LogRateLimitBurst": "0",
        "LogRateLimitIntervalUSec": "0",
        "LogsDirectoryMode": "0755",
        "MainPID": "0",
        "ManagedOOMMemoryPressure": "auto",
        "ManagedOOMMemoryPressureLimit": "0",
        "ManagedOOMPreference": "none",
        "ManagedOOMSwap": "auto",
        "MemoryAccounting": "yes",
        "MemoryCurrent": "[not set]",
        "MemoryDenyWriteExecute": "no",
        "MemoryHigh": "infinity",
        "MemoryLimit": "infinity",
        "MemoryLow": "0",
        "MemoryMax": "infinity",
        "MemoryMin": "0",
        "MemorySwapMax": "infinity",
        "MountAPIVFS": "no",
        "NFileDescriptorStore": "0",
        "NRestarts": "0",
        "NUMAPolicy": "n/a",
        "Names": "mongod.service",
        "NeedDaemonReload": "no",
        "Nice": "0",
        "NoNewPrivileges": "no",
        "NonBlocking": "no",
        "NotifyAccess": "none",
        "OOMPolicy": "stop",
        "OOMScoreAdjust": "0",
        "OnFailureJobMode": "replace",
        "PIDFile": "/run/mongodb/mongod.pid",
        "Perpetual": "no",
        "PrivateDevices": "no",
        "PrivateIPC": "no",
        "PrivateMounts": "no",
        "PrivateNetwork": "no",
        "PrivateTmp": "no",
        "PrivateUsers": "no",
        "ProcSubset": "all",
        "ProtectClock": "no",
        "ProtectControlGroups": "no",
        "ProtectHome": "no",
        "ProtectHostname": "no",
        "ProtectKernelLogs": "no",
        "ProtectKernelModules": "no",
        "ProtectKernelTunables": "no",
        "ProtectProc": "default",
        "ProtectSystem": "no",
        "RefuseManualStart": "no",
        "RefuseManualStop": "no",
        "ReloadResult": "success",
        "RemainAfterExit": "no",
        "RemoveIPC": "no",
        "Requires": "system.slice sysinit.target",
        "Restart": "no",
        "RestartKillSignal": "15",
        "RestartUSec": "100ms",
        "RestrictNamespaces": "no",
        "RestrictRealtime": "no",
        "RestrictSUIDSGID": "no",
        "Result": "success",
        "RootDirectoryStartOnly": "no",
        "RuntimeDirectoryMode": "0755",
        "RuntimeDirectoryPreserve": "no",
        "RuntimeMaxUSec": "infinity",
        "SameProcessGroup": "no",
        "SecureBits": "0",
        "SendSIGHUP": "no",
        "SendSIGKILL": "yes",
        "Slice": "system.slice",
        "StandardError": "inherit",
        "StandardInput": "null",
        "StandardOutput": "journal",
        "StartLimitAction": "none",
        "StartLimitBurst": "5",
        "StartLimitIntervalUSec": "10s",
        "StartupBlockIOWeight": "[not set]",
        "StartupCPUShares": "[not set]",
        "StartupCPUWeight": "[not set]",
        "StartupIOWeight": "[not set]",
        "StateChangeTimestampMonotonic": "0",
        "StateDirectoryMode": "0755",
        "StatusErrno": "0",
        "StopWhenUnneeded": "no",
        "SubState": "dead",
        "SuccessAction": "none",
        "SyslogFacility": "3",
        "SyslogLevel": "6",
        "SyslogLevelPrefix": "yes",
        "SyslogPriority": "30",
        "SystemCallErrorNumber": "2147483646",
        "TTYReset": "no",
        "TTYVHangup": "no",
        "TTYVTDisallocate": "no",
        "TasksAccounting": "no",
        "TasksCurrent": "[not set]",
        "TasksMax": "infinity",
        "TimeoutAbortUSec": "1min 30s",
        "TimeoutCleanUSec": "infinity",
        "TimeoutStartFailureMode": "terminate",
        "TimeoutStartUSec": "1min 30s",
        "TimeoutStopFailureMode": "terminate",
        "TimeoutStopUSec": "1min 30s",
        "TimerSlackNSec": "50000",
        "Transient": "no",
        "Type": "simple",
        "UID": "[not set]",
        "UMask": "0022",
        "UnitFilePreset": "enabled",
        "UnitFileState": "disabled",
        "User": "mongodb",
        "UtmpMode": "init",
        "Wants": "network-online.target",
        "WatchdogSignal": "6",
        "WatchdogTimestampMonotonic": "0",
        "WatchdogUSec": "infinity"
    }
}
vagrant@controller:/vagrant/5-managing-services$ ansible dbservers -m service -a "name=mongod state=started" --become
node-2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "name": "mongod",
    "state": "started",
    "status": {
        "ActiveEnterTimestamp": "Sat 2022-01-15 13:48:40 UTC",
        "ActiveEnterTimestampMonotonic": "2050615942",
        "ActiveExitTimestampMonotonic": "0",
        "ActiveState": "active",
        "After": "basic.target system.slice network-online.target systemd-journald.socket sysinit.target",
        "AllowIsolate": "no",
        "AssertResult": "yes",
        "AssertTimestamp": "Sat 2022-01-15 13:48:40 UTC",
        "AssertTimestampMonotonic": "2050615210",
        "Before": "shutdown.target",
        "BlockIOAccounting": "no",
        "BlockIOWeight": "[not set]",
        "CPUAccounting": "yes",
        "CPUAffinityFromNUMA": "no",
        "CPUQuotaPerSecUSec": "infinity",
        "CPUQuotaPeriodUSec": "infinity",
        "CPUSchedulingPolicy": "0",
        "CPUSchedulingPriority": "0",
        "CPUSchedulingResetOnFork": "no",
        "CPUShares": "[not set]",
        "CPUUsageNSec": "757534000",
        "CPUWeight": "[not set]",
        "CacheDirectoryMode": "0755",
        "CanFreeze": "yes",
        "CanIsolate": "no",
        "CanReload": "no",
        "CanStart": "yes",
        "CanStop": "yes",
        "CapabilityBoundingSet": "cap_chown cap_dac_override cap_dac_read_search cap_fowner cap_fsetid cap_kill cap_setgid cap_setuid cap_setpcap cap_linux_immutable cap_net_bind_service cap_net_broadcast cap_net_admin cap_net_raw cap_ipc_lock cap_ipc_owner cap_sys_module cap_sys_rawio cap_sys_chroot cap_sys_ptrace cap_sys_pacct cap_sys_admin cap_sys_boot cap_sys_nice cap_sys_resource cap_sys_time cap_sys_tty_config cap_mknod cap_lease cap_audit_write cap_audit_control cap_setfcap cap_mac_override cap_mac_admin cap_syslog cap_wake_alarm cap_block_suspend cap_audit_read cap_perfmon cap_bpf cap_checkpoint_restore",
        "CleanResult": "success",
        "CollectMode": "inactive",
        "ConditionResult": "yes",
        "ConditionTimestamp": "Sat 2022-01-15 13:48:40 UTC",
        "ConditionTimestampMonotonic": "2050615209",
        "ConfigurationDirectoryMode": "0755",
        "Conflicts": "shutdown.target",
        "ControlGroup": "/system.slice/mongod.service",
        "ControlPID": "0",
        "CoredumpFilter": "0x33",
        "DefaultDependencies": "yes",
        "DefaultMemoryLow": "0",
        "DefaultMemoryMin": "0",
        "Delegate": "no",
        "Description": "MongoDB Database Server",
        "DevicePolicy": "auto",
        "Documentation": "https://docs.mongodb.org/manual",
        "DynamicUser": "no",
        "EffectiveCPUs": "0",
        "EffectiveMemoryNodes": "0",
        "EnvironmentFiles": "/etc/default/mongod (ignore_errors=yes)",
        "ExecMainCode": "0",
        "ExecMainExitTimestampMonotonic": "0",
        "ExecMainPID": "4268",
        "ExecMainStartTimestamp": "Sat 2022-01-15 13:48:40 UTC",
        "ExecMainStartTimestampMonotonic": "2050615581",
        "ExecMainStatus": "0",
        "ExecStart": "{ path=/usr/bin/mongod ; argv[]=/usr/bin/mongod --config /etc/mongod.conf ; ignore_errors=no ; start_time=[Sat 2022-01-15 13:48:40 UTC] ; stop_time=[n/a] ; pid=4268 ; code=(null) ; status=0/0 }",
        "ExecStartEx": "{ path=/usr/bin/mongod ; argv[]=/usr/bin/mongod --config /etc/mongod.conf ; flags= ; start_time=[Sat 2022-01-15 13:48:40 UTC] ; stop_time=[n/a] ; pid=4268 ; code=(null) ; status=0/0 }",
        "FailureAction": "none",
        "FileDescriptorStoreMax": "0",
        "FinalKillSignal": "9",
        "FragmentPath": "/lib/systemd/system/mongod.service",
        "FreezerState": "running",
        "GID": "119",
        "Group": "mongodb",
        "GuessMainPID": "yes",
        "IOAccounting": "no",
        "IOReadBytes": "18446744073709551615",
        "IOReadOperations": "18446744073709551615",
        "IOSchedulingClass": "0",
        "IOSchedulingPriority": "0",
        "IOWeight": "[not set]",
        "IOWriteBytes": "18446744073709551615",
        "IOWriteOperations": "18446744073709551615",
        "IPAccounting": "no",
        "IPEgressBytes": "[no data]",
        "IPEgressPackets": "[no data]",
        "IPIngressBytes": "[no data]",
        "IPIngressPackets": "[no data]",
        "Id": "mongod.service",
        "IgnoreOnIsolate": "no",
        "IgnoreSIGPIPE": "yes",
        "InactiveEnterTimestampMonotonic": "0",
        "InactiveExitTimestamp": "Sat 2022-01-15 13:48:40 UTC",
        "InactiveExitTimestampMonotonic": "2050615942",
        "InvocationID": "159fc5e37a7345ad9206829355f3efa5",
        "JobRunningTimeoutUSec": "infinity",
        "JobTimeoutAction": "none",
        "JobTimeoutUSec": "infinity",
        "KeyringMode": "private",
        "KillMode": "control-group",
        "KillSignal": "15",
        "LimitAS": "infinity",
        "LimitASSoft": "infinity",
        "LimitCORE": "infinity",
        "LimitCORESoft": "0",
        "LimitCPU": "infinity",
        "LimitCPUSoft": "infinity",
        "LimitDATA": "infinity",
        "LimitDATASoft": "infinity",
        "LimitFSIZE": "infinity",
        "LimitFSIZESoft": "infinity",
        "LimitLOCKS": "infinity",
        "LimitLOCKSSoft": "infinity",
        "LimitMEMLOCK": "infinity",
        "LimitMEMLOCKSoft": "infinity",
        "LimitMSGQUEUE": "819200",
        "LimitMSGQUEUESoft": "819200",
        "LimitNICE": "0",
        "LimitNICESoft": "0",
        "LimitNOFILE": "64000",
        "LimitNOFILESoft": "64000",
        "LimitNPROC": "64000",
        "LimitNPROCSoft": "64000",
        "LimitRSS": "infinity",
        "LimitRSSSoft": "infinity",
        "LimitRTPRIO": "0",
        "LimitRTPRIOSoft": "0",
        "LimitRTTIME": "infinity",
        "LimitRTTIMESoft": "infinity",
        "LimitSIGPENDING": "1455",
        "LimitSIGPENDINGSoft": "1455",
        "LimitSTACK": "infinity",
        "LimitSTACKSoft": "8388608",
        "LoadState": "loaded",
        "LockPersonality": "no",
        "LogLevelMax": "-1",
        "LogRateLimitBurst": "0",
        "LogRateLimitIntervalUSec": "0",
        "LogsDirectoryMode": "0755",
        "MainPID": "4268",
        "ManagedOOMMemoryPressure": "auto",
        "ManagedOOMMemoryPressureLimit": "0",
        "ManagedOOMPreference": "none",
        "ManagedOOMSwap": "auto",
        "MemoryAccounting": "yes",
        "MemoryCurrent": "115208192",
        "MemoryDenyWriteExecute": "no",
        "MemoryHigh": "infinity",
        "MemoryLimit": "infinity",
        "MemoryLow": "0",
        "MemoryMax": "infinity",
        "MemoryMin": "0",
        "MemorySwapMax": "infinity",
        "MountAPIVFS": "no",
        "NFileDescriptorStore": "0",
        "NRestarts": "0",
        "NUMAPolicy": "n/a",
        "Names": "mongod.service",
        "NeedDaemonReload": "no",
        "Nice": "0",
        "NoNewPrivileges": "no",
        "NonBlocking": "no",
        "NotifyAccess": "none",
        "OOMPolicy": "stop",
        "OOMScoreAdjust": "0",
        "OnFailureJobMode": "replace",
        "PIDFile": "/run/mongodb/mongod.pid",
        "Perpetual": "no",
        "PrivateDevices": "no",
        "PrivateIPC": "no",
        "PrivateMounts": "no",
        "PrivateNetwork": "no",
        "PrivateTmp": "no",
        "PrivateUsers": "no",
        "ProcSubset": "all",
        "ProtectClock": "no",
        "ProtectControlGroups": "no",
        "ProtectHome": "no",
        "ProtectHostname": "no",
        "ProtectKernelLogs": "no",
        "ProtectKernelModules": "no",
        "ProtectKernelTunables": "no",
        "ProtectProc": "default",
        "ProtectSystem": "no",
        "RefuseManualStart": "no",
        "RefuseManualStop": "no",
        "ReloadResult": "success",
        "RemainAfterExit": "no",
        "RemoveIPC": "no",
        "Requires": "system.slice sysinit.target",
        "Restart": "no",
        "RestartKillSignal": "15",
        "RestartUSec": "100ms",
        "RestrictNamespaces": "no",
        "RestrictRealtime": "no",
        "RestrictSUIDSGID": "no",
        "Result": "success",
        "RootDirectoryStartOnly": "no",
        "RuntimeDirectoryMode": "0755",
        "RuntimeDirectoryPreserve": "no",
        "RuntimeMaxUSec": "infinity",
        "SameProcessGroup": "no",
        "SecureBits": "0",
        "SendSIGHUP": "no",
        "SendSIGKILL": "yes",
        "Slice": "system.slice",
        "StandardError": "inherit",
        "StandardInput": "null",
        "StandardOutput": "journal",
        "StartLimitAction": "none",
        "StartLimitBurst": "5",
        "StartLimitIntervalUSec": "10s",
        "StartupBlockIOWeight": "[not set]",
        "StartupCPUShares": "[not set]",
        "StartupCPUWeight": "[not set]",
        "StartupIOWeight": "[not set]",
        "StateChangeTimestamp": "Sat 2022-01-15 13:48:40 UTC",
        "StateChangeTimestampMonotonic": "2050615942",
        "StateDirectoryMode": "0755",
        "StatusErrno": "0",
        "StopWhenUnneeded": "no",
        "SubState": "running",
        "SuccessAction": "none",
        "SyslogFacility": "3",
        "SyslogLevel": "6",
        "SyslogLevelPrefix": "yes",
        "SyslogPriority": "30",
        "SystemCallErrorNumber": "2147483646",
        "TTYReset": "no",
        "TTYVHangup": "no",
        "TTYVTDisallocate": "no",
        "TasksAccounting": "no",
        "TasksCurrent": "[not set]",
        "TasksMax": "infinity",
        "TimeoutAbortUSec": "1min 30s",
        "TimeoutCleanUSec": "infinity",
        "TimeoutStartFailureMode": "terminate",
        "TimeoutStartUSec": "1min 30s",
        "TimeoutStopFailureMode": "terminate",
        "TimeoutStopUSec": "1min 30s",
        "TimerSlackNSec": "50000",
        "Transient": "no",
        "Type": "simple",
        "UID": "112",
        "UMask": "0022",
        "UnitFilePreset": "enabled",
        "UnitFileState": "disabled",
        "User": "mongodb",
        "UtmpMode": "init",
        "Wants": "network-online.target",
        "WatchdogSignal": "6",
        "WatchdogTimestampMonotonic": "0",
        "WatchdogUSec": "0"
    }
}
vagrant@controller:/vagrant/5-managing-services$
```

Checking on the mongod

```
vagrant@node-2:~$ sudo service mongod status
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; disabled; vendor preset: enabled)
     Active: active (running) since Sat 2022-01-15 13:48:40 UTC; 55s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 4268 (mongod)
     Memory: 110.1M
        CPU: 1.100s
     CGroup: /system.slice/mongod.service
             └─4268 /usr/bin/mongod --config /etc/mongod.conf

Jan 15 13:48:40 node-2 systemd[1]: Started MongoDB Database Server.
vagrant@node-2:~$ mongo
MongoDB shell version v5.0.5
connecting to: mongodb://127.0.0.1:27017/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("cec20b9d-1d1c-429c-8d21-691cff141082") }
MongoDB server version: 5.0.5
================
Warning: the "mongo" shell has been superseded by "mongosh",
which delivers improved usability and compatibility.The "mongo" shell has been deprecated and will be removed in
an upcoming release.
For installation instructions, see
https://docs.mongodb.com/mongodb-shell/install/
================
Welcome to the MongoDB shell.
For interactive help, type "help".
For more comprehensive documentation, see
	https://docs.mongodb.com/
Questions? Try the MongoDB Developer Community Forums
	https://community.mongodb.com
---
The server generated these startup warnings when booting:
        2022-01-15T13:48:40.448+00:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
        2022-01-15T13:48:41.117+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
---
---
        Enable MongoDB's free cloud-based monitoring service, which will then receive and display
        metrics about your deployment (disk utilization, CPU, operation statistics, etc).

        The monitoring data will be available on a MongoDB website with a unique URL accessible to you
        and anyone you share the URL with. MongoDB may use this information to make product
        improvements and to suggest MongoDB products and deployment options to you.

        To enable free monitoring, run the following command: db.enableFreeMonitoring()
        To permanently disable this reminder, run the following command: db.disableFreeMonitoring()
---
>
```

Stop Mongo

```
vagrant@controller:/vagrant/5-managing-services$ ansible dbservers -m service -a "name=mongod state=stopped" --become
node-2 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "name": "mongod",
    "state": "stopped",
    "status": {
        "ActiveEnterTimestamp": "Sat 2022-01-15 13:48:40 UTC",
        "ActiveEnterTimestampMonotonic": "2050615942",
        "ActiveExitTimestampMonotonic": "0",
        "ActiveState": "active",
        "After": "basic.target system.slice network-online.target systemd-journald.socket sysinit.target",
        "AllowIsolate": "no",
        "AssertResult": "yes",
        "AssertTimestamp": "Sat 2022-01-15 13:48:40 UTC",
        "AssertTimestampMonotonic": "2050615210",
        "Before": "shutdown.target",
        "BlockIOAccounting": "no",
        "BlockIOWeight": "[not set]",
        "CPUAccounting": "yes",
        "CPUAffinityFromNUMA": "no",
        "CPUQuotaPerSecUSec": "infinity",
        "CPUQuotaPeriodUSec": "infinity",
        "CPUSchedulingPolicy": "0",
        "CPUSchedulingPriority": "0",
        "CPUSchedulingResetOnFork": "no",
        "CPUShares": "[not set]",
        "CPUUsageNSec": "1879452000",
        "CPUWeight": "[not set]",
        "CacheDirectoryMode": "0755",
        "CanFreeze": "yes",
        "CanIsolate": "no",
        "CanReload": "no",
        "CanStart": "yes",
        "CanStop": "yes",
        "CapabilityBoundingSet": "cap_chown cap_dac_override cap_dac_read_search cap_fowner cap_fsetid cap_kill cap_setgid cap_setuid cap_setpcap cap_linux_immutable cap_net_bind_service cap_net_broadcast cap_net_admin cap_net_raw cap_ipc_lock cap_ipc_owner cap_sys_module cap_sys_rawio cap_sys_chroot cap_sys_ptrace cap_sys_pacct cap_sys_admin cap_sys_boot cap_sys_nice cap_sys_resource cap_sys_time cap_sys_tty_config cap_mknod cap_lease cap_audit_write cap_audit_control cap_setfcap cap_mac_override cap_mac_admin cap_syslog cap_wake_alarm cap_block_suspend cap_audit_read cap_perfmon cap_bpf cap_checkpoint_restore",
        "CleanResult": "success",
        "CollectMode": "inactive",
        "ConditionResult": "yes",
        "ConditionTimestamp": "Sat 2022-01-15 13:48:40 UTC",
        "ConditionTimestampMonotonic": "2050615209",
        "ConfigurationDirectoryMode": "0755",
        "Conflicts": "shutdown.target",
        "ControlGroup": "/system.slice/mongod.service",
        "ControlPID": "0",
        "CoredumpFilter": "0x33",
        "DefaultDependencies": "yes",
        "DefaultMemoryLow": "0",
        "DefaultMemoryMin": "0",
        "Delegate": "no",
        "Description": "MongoDB Database Server",
        "DevicePolicy": "auto",
        "Documentation": "https://docs.mongodb.org/manual",
        "DynamicUser": "no",
        "EffectiveCPUs": "0",
        "EffectiveMemoryNodes": "0",
        "EnvironmentFiles": "/etc/default/mongod (ignore_errors=yes)",
        "ExecMainCode": "0",
        "ExecMainExitTimestampMonotonic": "0",
        "ExecMainPID": "4268",
        "ExecMainStartTimestamp": "Sat 2022-01-15 13:48:40 UTC",
        "ExecMainStartTimestampMonotonic": "2050615581",
        "ExecMainStatus": "0",
        "ExecStart": "{ path=/usr/bin/mongod ; argv[]=/usr/bin/mongod --config /etc/mongod.conf ; ignore_errors=no ; start_time=[Sat 2022-01-15 13:48:40 UTC] ; stop_time=[n/a] ; pid=4268 ; code=(null) ; status=0/0 }",
        "ExecStartEx": "{ path=/usr/bin/mongod ; argv[]=/usr/bin/mongod --config /etc/mongod.conf ; flags= ; start_time=[Sat 2022-01-15 13:48:40 UTC] ; stop_time=[n/a] ; pid=4268 ; code=(null) ; status=0/0 }",
        "FailureAction": "none",
        "FileDescriptorStoreMax": "0",
        "FinalKillSignal": "9",
        "FragmentPath": "/lib/systemd/system/mongod.service",
        "FreezerState": "running",
        "GID": "119",
        "Group": "mongodb",
        "GuessMainPID": "yes",
        "IOAccounting": "no",
        "IOReadBytes": "18446744073709551615",
        "IOReadOperations": "18446744073709551615",
        "IOSchedulingClass": "0",
        "IOSchedulingPriority": "0",
        "IOWeight": "[not set]",
        "IOWriteBytes": "18446744073709551615",
        "IOWriteOperations": "18446744073709551615",
        "IPAccounting": "no",
        "IPEgressBytes": "[no data]",
        "IPEgressPackets": "[no data]",
        "IPIngressBytes": "[no data]",
        "IPIngressPackets": "[no data]",
        "Id": "mongod.service",
        "IgnoreOnIsolate": "no",
        "IgnoreSIGPIPE": "yes",
        "InactiveEnterTimestampMonotonic": "0",
        "InactiveExitTimestamp": "Sat 2022-01-15 13:48:40 UTC",
        "InactiveExitTimestampMonotonic": "2050615942",
        "InvocationID": "159fc5e37a7345ad9206829355f3efa5",
        "JobRunningTimeoutUSec": "infinity",
        "JobTimeoutAction": "none",
        "JobTimeoutUSec": "infinity",
        "KeyringMode": "private",
        "KillMode": "control-group",
        "KillSignal": "15",
        "LimitAS": "infinity",
        "LimitASSoft": "infinity",
        "LimitCORE": "infinity",
        "LimitCORESoft": "0",
        "LimitCPU": "infinity",
        "LimitCPUSoft": "infinity",
        "LimitDATA": "infinity",
        "LimitDATASoft": "infinity",
        "LimitFSIZE": "infinity",
        "LimitFSIZESoft": "infinity",
        "LimitLOCKS": "infinity",
        "LimitLOCKSSoft": "infinity",
        "LimitMEMLOCK": "infinity",
        "LimitMEMLOCKSoft": "infinity",
        "LimitMSGQUEUE": "819200",
        "LimitMSGQUEUESoft": "819200",
        "LimitNICE": "0",
        "LimitNICESoft": "0",
        "LimitNOFILE": "64000",
        "LimitNOFILESoft": "64000",
        "LimitNPROC": "64000",
        "LimitNPROCSoft": "64000",
        "LimitRSS": "infinity",
        "LimitRSSSoft": "infinity",
        "LimitRTPRIO": "0",
        "LimitRTPRIOSoft": "0",
        "LimitRTTIME": "infinity",
        "LimitRTTIMESoft": "infinity",
        "LimitSIGPENDING": "1455",
        "LimitSIGPENDINGSoft": "1455",
        "LimitSTACK": "infinity",
        "LimitSTACKSoft": "8388608",
        "LoadState": "loaded",
        "LockPersonality": "no",
        "LogLevelMax": "-1",
        "LogRateLimitBurst": "0",
        "LogRateLimitIntervalUSec": "0",
        "LogsDirectoryMode": "0755",
        "MainPID": "4268",
        "ManagedOOMMemoryPressure": "auto",
        "ManagedOOMMemoryPressureLimit": "0",
        "ManagedOOMPreference": "none",
        "ManagedOOMSwap": "auto",
        "MemoryAccounting": "yes",
        "MemoryCurrent": "111501312",
        "MemoryDenyWriteExecute": "no",
        "MemoryHigh": "infinity",
        "MemoryLimit": "infinity",
        "MemoryLow": "0",
        "MemoryMax": "infinity",
        "MemoryMin": "0",
        "MemorySwapMax": "infinity",
        "MountAPIVFS": "no",
        "NFileDescriptorStore": "0",
        "NRestarts": "0",
        "NUMAPolicy": "n/a",
        "Names": "mongod.service",
        "NeedDaemonReload": "no",
        "Nice": "0",
        "NoNewPrivileges": "no",
        "NonBlocking": "no",
        "NotifyAccess": "none",
        "OOMPolicy": "stop",
        "OOMScoreAdjust": "0",
        "OnFailureJobMode": "replace",
        "PIDFile": "/run/mongodb/mongod.pid",
        "Perpetual": "no",
        "PrivateDevices": "no",
        "PrivateIPC": "no",
        "PrivateMounts": "no",
        "PrivateNetwork": "no",
        "PrivateTmp": "no",
        "PrivateUsers": "no",
        "ProcSubset": "all",
        "ProtectClock": "no",
        "ProtectControlGroups": "no",
        "ProtectHome": "no",
        "ProtectHostname": "no",
        "ProtectKernelLogs": "no",
        "ProtectKernelModules": "no",
        "ProtectKernelTunables": "no",
        "ProtectProc": "default",
        "ProtectSystem": "no",
        "RefuseManualStart": "no",
        "RefuseManualStop": "no",
        "ReloadResult": "success",
        "RemainAfterExit": "no",
        "RemoveIPC": "no",
        "Requires": "system.slice sysinit.target",
        "Restart": "no",
        "RestartKillSignal": "15",
        "RestartUSec": "100ms",
        "RestrictNamespaces": "no",
        "RestrictRealtime": "no",
        "RestrictSUIDSGID": "no",
        "Result": "success",
        "RootDirectoryStartOnly": "no",
        "RuntimeDirectoryMode": "0755",
        "RuntimeDirectoryPreserve": "no",
        "RuntimeMaxUSec": "infinity",
        "SameProcessGroup": "no",
        "SecureBits": "0",
        "SendSIGHUP": "no",
        "SendSIGKILL": "yes",
        "Slice": "system.slice",
        "StandardError": "inherit",
        "StandardInput": "null",
        "StandardOutput": "journal",
        "StartLimitAction": "none",
        "StartLimitBurst": "5",
        "StartLimitIntervalUSec": "10s",
        "StartupBlockIOWeight": "[not set]",
        "StartupCPUShares": "[not set]",
        "StartupCPUWeight": "[not set]",
        "StartupIOWeight": "[not set]",
        "StateChangeTimestamp": "Sat 2022-01-15 13:48:40 UTC",
        "StateChangeTimestampMonotonic": "2050615942",
        "StateDirectoryMode": "0755",
        "StatusErrno": "0",
        "StopWhenUnneeded": "no",
        "SubState": "running",
        "SuccessAction": "none",
        "SyslogFacility": "3",
        "SyslogLevel": "6",
        "SyslogLevelPrefix": "yes",
        "SyslogPriority": "30",
        "SystemCallErrorNumber": "2147483646",
        "TTYReset": "no",
        "TTYVHangup": "no",
        "TTYVTDisallocate": "no",
        "TasksAccounting": "no",
        "TasksCurrent": "[not set]",
        "TasksMax": "infinity",
        "TimeoutAbortUSec": "1min 30s",
        "TimeoutCleanUSec": "infinity",
        "TimeoutStartFailureMode": "terminate",
        "TimeoutStartUSec": "1min 30s",
        "TimeoutStopFailureMode": "terminate",
        "TimeoutStopUSec": "1min 30s",
        "TimerSlackNSec": "50000",
        "Transient": "no",
        "Type": "simple",
        "UID": "112",
        "UMask": "0022",
        "UnitFilePreset": "enabled",
        "UnitFileState": "disabled",
        "User": "mongodb",
        "UtmpMode": "init",
        "Wants": "network-online.target",
        "WatchdogSignal": "6",
        "WatchdogTimestampMonotonic": "0",
        "WatchdogUSec": "0"
    }
}
vagrant@controller:/vagrant/5-managing-services$
```

```
vagrant@node-2:~$ sudo service mongod status
○ mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; disabled; vendor preset: enabled)
     Active: inactive (dead)
       Docs: https://docs.mongodb.org/manual

Jan 15 13:48:40 node-2 systemd[1]: Started MongoDB Database Server.
Jan 15 13:51:05 node-2 systemd[1]: Stopping MongoDB Database Server...
Jan 15 13:51:05 node-2 systemd[1]: mongod.service: Deactivated successfully.
Jan 15 13:51:05 node-2 systemd[1]: Stopped MongoDB Database Server.
Jan 15 13:51:05 node-2 systemd[1]: mongod.service: Consumed 1.886s CPU time.
vagrant@node-2:~$
```

Restart MongoDB

- `ansible dbservers -m service -a "name=mongod state=restarted" --become`

Reload MongoDB

- `ansible dbservers -m service -a "name=mongod state=reloaded" --become`

