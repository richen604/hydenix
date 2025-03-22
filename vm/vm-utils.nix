{ pkgs }:
rec {
  # Common function to create default network
  createDefaultNetwork = ''
    if ! sudo ${pkgs.libvirt}/bin/virsh net-list --all | grep -q "default"; then
      sudo ${pkgs.libvirt}/bin/virsh net-define /dev/stdin <<EOF
    <network>
      <name>default</name>
      <forward mode='nat'/>
      <bridge name='virbr0' stp='on' delay='0'/>
      <ip address='192.168.122.1' netmask='255.255.255.0'>
        <dhcp>
          <range start='192.168.122.2' end='192.168.122.254'/>
        </dhcp>
      </ip>
    </network>
    EOF
      sudo ${pkgs.libvirt}/bin/virsh net-start default
      sudo ${pkgs.libvirt}/bin/virsh net-autostart default
    fi
  '';

  # Common function to clean up existing VM
  cleanupVM = vmName: ''
    if sudo ${pkgs.libvirt}/bin/virsh list --all | grep -q "${vmName}"; then
      sudo ${pkgs.libvirt}/bin/virsh destroy "${vmName}" || true
      sudo ${pkgs.libvirt}/bin/virsh undefine "${vmName}" --remove-all-storage
    fi
  '';

  # Common function to launch VM viewer
  launchViewer = vmName: userConfig: ''
    echo "To connect to the VM, use: virt-viewer --connect qemu:///system --attach ${vmName}"
    echo "Default login: username '${userConfig.username}', password '${userConfig.defaultPassword}'"

    sleep 5

    if [ "$DISPLAY" != "" ]; then
      ${pkgs.xorg.xhost}/bin/xhost +SI:localuser:$(id -un)
      sudo -E ${pkgs.virt-viewer}/bin/virt-viewer --connect qemu:///system --attach "${vmName}"
    else
      echo "No display detected. Unable to open virt-viewer automatically."
      echo "You can try running 'virt-viewer --connect qemu:///system --attach ${vmName}' manually when X is available."
    fi
  '';

  # Common function to create and start VM
  createAndStartVM =
    {
      vmName,
      vmImage,
      osVariant,
      userConfig,
    }:
    ''
      ${createDefaultNetwork}

      ${cleanupVM vmName}

      sudo ${pkgs.virt-manager}/bin/virt-install \
        --connect qemu:///system \
        --name "${vmName}" \
        --memory ${toString userConfig.vm.memorySize} \
        --vcpus ${toString userConfig.vm.cores} \
        --disk path=${vmImage},format=qcow2 \
        --import \
        --os-variant ${osVariant} \
        --network network=default \
        --graphics spice,gl.enable=yes,listen=none,rendernode=/dev/dri/renderD128 \
        --video virtio \
        --noautoconsole

      sudo ${pkgs.libvirt}/bin/virsh --connect qemu:///system start "${vmName}"

      ${launchViewer vmName userConfig}
    '';
}
