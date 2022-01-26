# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|

  (1..3).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.box = "rkrause/ubuntu-21.10-arm64"
      node.vm.box_version = "1.0.0"
      node.vm.hostname = "node-#{i}"
      node.vm.network "private_network", ip: "10.10.10.1#{i}", netmask:"255.255.0.0"
      node.vm.provider :vmware_fusion do |vmware|
        vmware.vmx["memsize"] = "512"
        vmware.vmx["numvcpus"] = 1
        vmware.vmx["ethernet0.pcislotnumber"] = "160"
        # vmware.gui = true
      end
    end
  end

  config.vm.define "controller" do |controller|
    controller.vm.box = "rkrause/ubuntu-21.10-arm64"  # this one seems to be faster to boot
    # controller.vm.box = "bytesguy/ubuntu-server-21.10-arm64"
    controller.vm.box_version = "1.0.0"
    controller.vm.hostname = "controller"
    controller.vm.network "private_network", ip: "10.10.10.10", netmask:"255.255.0.0"
    controller.vm.provider :vmware_fusion do |vmware|
        vmware.vmx["memsize"] = "512"
        vmware.vmx["numvcpus"] = 1
        vmware.vmx["ethernet0.pcislotnumber"] = "160"
        # vmware.gui = true
    end
    controller.vm.provision :shell, path: 'ubuntu-setup.sh'
  end
end