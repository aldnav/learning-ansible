# Learning Ansible

## Environment

| | |
| ----------- | ----------- |
| Host machine | Apple M1 Pro |
| Provider | [VMWare Fusion Tech Previer](https://www.vmware.com/asean/products/fusion.html) |

[Guide](https://gist.github.com/sbailliez/f22db6434ac84eccb6d3c8833c85ad92) and [discussion](https://github.com/hashicorp/vagrant-vmware-desktop/issues/22) to setting up VMWare Fusion Tech Preview as provider for Mac M1.

---

## Common pitfalls 🕳

- Vagrant fails to connect to SSH when network is not stable. I am using 4G data connection. Seems to be internal setup of the network in the VM and changes to the host machine's network connection is spotty.
  - Resolution: Use stable connection if possible. Then do `vagrant reload`
- Vagrant fails to destroy machines that were setup prior to doing updates to the Vagrantfile. Vagrant reads the Vagrantfile and doesn't do differential of states in between command.
  - Resolution: Run `vagrant destroy` first before making changes to Vagrantfile
- Running ansible ad-hoc commands on a different directory from the `ansible.cfg`
- Role hierarchy honors the sequence that is defined on the playbook roles
  - This is important when some tasks need to be run first before the specific roles
    - Example would  be `pip3` from the `backend` role needs to be installed first, and then `flask` from the `flask` role can be installed.

        ```console
        PLAY [backend-developers] *****************************************************************************************************************************************************************************************

        TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
        ok: [node-1]

        TASK [flask : install Flask python framework] *********************************************************************************************************************************************************************
        fatal: [node-1]: FAILED! => {"changed": false, "msg": "Unable to find any of pip3 to use.  pip needs to be installed."}

        PLAY RECAP ********************************************************************************************************************************************************************************************************
        node-1                     : ok=4    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0
        node-2                     : ok=9    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

        ```

## General tips

- Use `vagrant --debug` when stuck with provisioning VMs
- Start VM provider (VMWare Fusion Tech Preview in my case) first to see if the VMs are fine, or the vagrant plugins start
- Vagrant may/may not purge VMs. In this case, the VM provider GUI might be easier to use to delete remnant images
- Use `ansible -vvvv` to increase verbosity while debugging