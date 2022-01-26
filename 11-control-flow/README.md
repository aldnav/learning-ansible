# Control flow

Decision making capabilities of Ansible Playbooks

Example: Playbook responds to different OSes

⚠️ Cannot use Red Hat. As of writing, there is no compatible Red Hat Linux box for ARM or Apple Silicon.

```
cat /path/to/.vagrant/machines/redhat-node/vmware_desktop/040458a2-3e45-43b4-8adc-16fa6bfd6e1f/vmware.log
2022-01-19T11:00:49.994Z In(05) vmx [msg.guestos.badArch] This virtual machine cannot be powered on because it requires the X86 machine architecture, which is incompatible with this Arm machine architecture host. See KB-84273.
```

Trying a Fedora box instead [(scottharwell/fedora-35-aarch64)](https://app.vagrantup.com/scottharwell/boxes/fedora-35-aarch64)

```yaml
# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
    config.vm.define "controller" do |controller|
      controller.vm.box = "rkrause/ubuntu-21.10-arm64"  # this one seems to be faster to boot
      # controller.vm.box = "bytesguy/ubuntu-server-21.10-arm64"
      controller.vm.box_version = "1.0.0"
      controller.vm.hostname = "controller"
      controller.vm.network "private_network", ip: "10.10.10.10"
      controller.vm.provider :vmware_desktop do |vmware|
          vmware.vmx["memsize"] = "512"
          vmware.vmx["numvcpus"] = 1
      end
      controller.vm.provision :shell, path: 'ubuntu-setup.sh'
    end
  
    (1..2).each do |i|
      config.vm.define "node-#{i}" do |node|
        node.vm.box = "rkrause/ubuntu-21.10-arm64"
        node.vm.box_version = "1.0.0"
        node.vm.hostname = "node-#{i}"
        node.vm.network "private_network", ip: "10.10.10.1#{i}"
        node.vm.provider :vmware_desktop do |vmware|
          vmware.vmx["memsize"] = "512"
          vmware.vmx["numvcpus"] = 1
        end
      end
    end

    # config.vm.define "redhat-node" do |redhat|
    #     redhat.vm.box = "kashfay110/redhat7"
    #     redhat.vm.hostname = "redhat-node"
    #     redhat.vm.network "private_network", ip: "10.10.10.13"
    #     redhat.vm.provider :vmware_desktop do |vmware|
    #         vmware.vmx["memsize"] = "512"
    #         vmware.vmx["numvcpus"] = 1
    #     end
    #     redhat.ssh.insert_key = false
    # end

    config.vm.define "fedora-node" do |fedoranode|
        fedoranode.vm.box = "scottharwell/fedora-35-aarch64"
        fedoranode.vm.box_version = "1.0.1"
        fedoranode.vm.hostname = "fedora-node"
        fedoranode.vm.network "private_network", ip: "10.10.10.13"
        fedoranode.vm.provider :parallels do |parallels|
            parallels.memory = 512
            parallels.cpus = 1
        end
        fedoranode.ssh.insert_key = false
    end

  end
```

Output.

```
==> fedora-node: Box 'scottharwell/fedora-35-aarch64' could not be found. Attempting to find and install...
    fedora-node: Box Provider: vmware_desktop, vmware_fusion, vmware_workstation
    fedora-node: Box Version: 1.0.1
==> fedora-node: Loading metadata for box 'scottharwell/fedora-35-aarch64'
    fedora-node: URL: https://vagrantcloud.com/scottharwell/fedora-35-aarch64
The box you're attempting to add doesn't support the provider
you requested. Please find an alternate box or use an alternate
provider. Double-check your requested provider to verify you didn't
simply misspell it.

If you're adding a box from HashiCorp's Vagrant Cloud, make sure the box is
released.

Name: scottharwell/fedora-35-aarch64
Address: https://vagrantcloud.com/scottharwell/fedora-35-aarch64
Requested provider: ["vmware_desktop", "vmware_fusion", "vmware_workstation"]
```

Oops. Forgot to install Parallels plug-in.

```
☁  8-handlers [main] ⚡  vagrant plugin install vagrant-parallels
Installing the 'vagrant-parallels' plugin. This can take a few minutes...
Fetching nokogiri-1.13.1-x86_64-darwin.gem
Fetching vagrant-parallels-2.2.4.gem
Installed the plugin 'vagrant-parallels (2.2.4)'!
```

Trying again.

```
☁  8-handlers [main] ⚡  vagrant up
Bringing machine 'controller' up with 'vmware_desktop' provider...
Bringing machine 'node-1' up with 'vmware_desktop' provider...
Bringing machine 'node-2' up with 'vmware_desktop' provider...
Bringing machine 'fedora-node' up with 'parallels' provider...
==> controller: Checking if box 'rkrause/ubuntu-21.10-arm64' version '1.0.0' is up to date...
==> controller: There was a problem while downloading the metadata for your box
==> controller: to check for updates. This is not an error, since it is usually due
==> controller: to temporary network problems. This is just a warning. The problem
==> controller: encountered was:
==> controller:
==> controller: Could not resolve host: vagrantcloud.com
==> controller:
==> controller: If you want to check for box updates, verify your network connection
==> controller: is valid and try again.
==> controller: Machine is already running.
==> node-1: Checking if box 'rkrause/ubuntu-21.10-arm64' version '1.0.0' is up to date...
==> node-1: Machine is already running.
==> node-2: Checking if box 'rkrause/ubuntu-21.10-arm64' version '1.0.0' is up to date...
==> node-2: Machine is already running.
==> fedora-node: Box 'scottharwell/fedora-35-aarch64' could not be found. Attempting to find and install...
    fedora-node: Box Provider: parallels
    fedora-node: Box Version: 1.0.1
==> fedora-node: Loading metadata for box 'scottharwell/fedora-35-aarch64'
    fedora-node: URL: https://vagrantcloud.com/scottharwell/fedora-35-aarch64
==> fedora-node: Adding box 'scottharwell/fedora-35-aarch64' (v1.0.1) for provider: parallels
    fedora-node: Downloading: https://vagrantcloud.com/scottharwell/boxes/fedora-35-aarch64/versions/1.0.1/providers/parallels.box
==> fedora-node: Box download is resuming from prior download progress
==> fedora-node: Successfully added box 'scottharwell/fedora-35-aarch64' (v1.0.1) for 'parallels'!
==> fedora-node: Registering VM image from the base box 'scottharwell/fedora-35-aarch64'...
==> fedora-node: Creating new virtual machine as a linked clone of the box image...
==> fedora-node: Unregistering the box VM image...
==> fedora-node: Setting the default configuration for VM...
==> fedora-node: Checking if box 'scottharwell/fedora-35-aarch64' version '1.0.1' is up to date...
==> fedora-node: Setting the name of the VM: 1-setting-up_fedora-node_1642625169601_72142
==> fedora-node: Fixed port collision for 22 => 2222. Now on port 2201.
==> fedora-node: Preparing network interfaces based on configuration...
    fedora-node: Adapter 0: shared
    fedora-node: Adapter 1: hostonly
==> fedora-node: Clearing any previously set network interfaces...
==> fedora-node: Running 'pre-boot' VM customizations...
==> fedora-node: Booting VM...
There was an error while command execution. The command and stderr is shown below.

Command: ["/usr/local/bin/prlctl", "start", "7abfc1bf-3243-4594-95a1-74b99671a3f0"]

Stderr: Failed to start the VM: This product was activated for a limited period of time that has now expired. Purchase a new activation key (https://www.parallels.com/buy-pdfm17-en_PH/) to continue using Parallels Desktop.
```

Nope. Not having a Parallels run VM either. It's expensive just to test out control flow.

Just taking notes for now.

## 📝 Using `when`

```yaml
--- using when
- hosts: webservers
  become: true
  tasks:
    - name: "install apache2 webserver"
      apt:
        name: apache2
        state: present
      when: ansible_os_family == "Debian"
    - name: "install httpd webserver"
      apt:
        name: httpd
        state: present
      when: ansible_os_family == "Redhat"
```

Cons:  

- Hard to maintain

Set of user files.

Scenario: Put in user configuration when a name exists (arbitrary condition)

```yaml
--- setup user configuration using when
- hosts: webservers
  become: true
  vars:
    users:
      - "Justin"
      - "Aubri"
      - "Cherokee"
      - "Daniel"
      - "Zach"
  tasks:
    - name: "install apache2 webserver"
      apt:
        name: apache2
        state: present
      when: ansible_os_family == "Debian"
    - name: "install httpd webserver"
      apt:
        name: httpd
        state: present
      when: ansible_os_family == "Redhat"
    - name: "remove previous user configuration"  # just for educational purposes  
      file:
        path: /tmp/users.xml
        state: absent
    - name: "setup user configuration"
      template:
        src: ./users.xml.j2
        dest: /tmp/users.xml
      when: "'Cherokee' in users"  # Condition: Is the username in the list of users?
```

Templating is a way of using Jinja2 templating engine to abstract away repetitive tasks.

Template: users.xml.j2

```j2
<Users>
  {% for user in users %}
  <User>{{ user }}</User>
  {% endfor %}
</Users>
```

Pros:

- Customizable
- Specificity

## 📝 Using `roles`

Next lesson.

## 📝 Using variable rules

```yaml
--- setup user configuration using when
- hosts: webservers
  become: true
  vars:
    users:
      - "Justin"
      - "Aubri"
      - "Cherokee"
      - "Daniel"
      - "Zach"
  vars_files:
    - "./{{ ansible_os_family }}.variables.yml"
  handlers:
    - name: "restart the webserver"
      service:
        name: "{{ webserver }}"
        state: restarted
  tasks:
    - name: "install apache2 webserver"
      apt:
        name: apache2
        state: present
      when: ansible_os_family == "Debian"
    - name: "install httpd webserver"
      apt:
        name: httpd
        state: present
      when: ansible_os_family == "RedHat"
    - name: "remove previous user configuration"  # just for educational purposes  
      file:
        path: /tmp/users.xml
        state: absent
    - name: "setup user configuration"
      template:
        src: ./users.xml.j2
        dest: /tmp/users.xml
      when: "'Cherokee' in users"  # Condition: Is the username in the list of users?
      notify: "restart the webserver"
```

```yaml
--- RedHat.variables.yml
webserver: "apache2"
```

```yaml
--- Debian.variables.yml
webserver: "httpd"
```

Defined same variable name depending on the platform.
