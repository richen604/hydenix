{ pkgs, userConfig, ... }:

let
  vmUtils = import ./vm-utils.nix { inherit pkgs; };
  vmName = "fedora-vm";
  vmImage = "output-fedora-vm/fedora-vm";

  generateKickstartScript = pkgs.writeShellScriptBin "generate-kickstart" ''
    #!/bin/bash
    # Define variables from userConfig
    ROOT_PASSWORD="${userConfig.defaultPassword}"
    USERNAME="${userConfig.username}"
    USER_PASSWORD="${userConfig.defaultPassword}"
    DISK_SIZE=${toString userConfig.vm.diskSize}

    # Calculate partition sizes based on disk size
    ROOT_SIZE=$((DISK_SIZE * 70 / 100))  # 70% for root
    HOME_SIZE=$((DISK_SIZE * 20 / 100))  # 20% for home
    SWAP_SIZE=$((DISK_SIZE * 5 / 100))  # 5% for swap

    # Path to the original Kickstart template
    KICKSTART_TEMPLATE="${toString ./.}/scripts/preseed/fedora-kickstart.ks.template"

    # Use a temporary directory for the processed Kickstart file
    TEMP_DIR="/tmp/fedora-kickstart"
    mkdir -p $TEMP_DIR
    KICKSTART_PROCESSED="$TEMP_DIR/fedora-kickstart.ks"

    # Replace placeholders with actual values
    sudo sed -e "s/{{ root_password }}/$ROOT_PASSWORD/g" \
        -e "s/{{ username }}/$USERNAME/g" \
        -e "s/{{ user_password }}/$USER_PASSWORD/g" \
        -e "s/{{ root_size }}/$ROOT_SIZE/g" \
        -e "s/{{ home_size }}/$HOME_SIZE/g" \
        -e "s/{{ swap_size }}/$SWAP_SIZE/g" \
        $KICKSTART_TEMPLATE > $KICKSTART_PROCESSED
  '';

  fedoraVmHcl = pkgs.writeText "fedora-vm.pkr.hcl" ''
    packer {
      required_plugins {
        qemu = {
          version = ">= 1.0.0"
          source  = "github.com/hashicorp/qemu"
        }
      }
    }

    source "qemu" "fedora" {
      iso_url           = "https://download.fedoraproject.org/pub/fedora/linux/releases/40/Server/x86_64/iso/Fedora-Server-dvd-x86_64-40-1.14.iso"
      iso_checksum      = "32d9ab1798fc8106a0b06e873bdcd83a3efea8412c9401dfe4097347ed0cfc65"
      output_directory  = "output-fedora-vm"
      shutdown_command  = "echo 'packer' | sudo -S shutdown -P now"
      disk_size         = "${toString userConfig.vm.diskSize}"
      format            = "qcow2"
      accelerator       = "kvm"
      ssh_username      = "${userConfig.username}"
      ssh_password      = "${userConfig.defaultPassword}"
      ssh_timeout       = "20m"
      vm_name           = "fedora-vm"
      memory            = "${toString userConfig.vm.memorySize}"
      cpus              = "${toString userConfig.vm.cores}"
      headless          = false
      boot_command      = [
        "<wait3s><up><wait>",
        "e",
        "<down><down><down><left>",
        " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/fedora-kickstart.ks<f10><wait>"
      ]
      http_directory    = "/tmp/fedora-kickstart"
      ssh_handshake_attempts = "20"
    }

    build {
      sources = ["source.qemu.fedora"]

      provisioner "shell" {
        inline = [
          "sudo dnf update -y",
          "sudo dnf install -y git vim",
          "echo 'Size of /root:' && sudo du -sh /root",
          "echo 'Size of /home:' && sudo du -sh /home"
        ]
      }

      provisioner "shell" {
        script = "${toString ./.}/scripts/install-nix.sh"
      }

      provisioner "shell" {
        script = "${toString ./.}/../../lib/gen-config.sh"
      }

      provisioner "shell" {
        inline = [
          "mkdir -p /home/${userConfig.username}/hydenix/hydenix"
        ]
      }

      provisioner "file" {
        source      = "${toString ./.}/../../"
        destination = "/home/${userConfig.username}/hydenix"
      }

      provisioner "shell" {
        script = "${toString ./.}/scripts/install/fedora-setup.sh"
      }

      provisioner "shell" {
        inline = [
          "cd /home/${userConfig.username}/hydenix/hydenix",
          ". /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh",
          "nix run home-manager/master -- switch --flake .#${userConfig.username}-generic",
          "nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update",
          "nix-env -iA nixgl.auto.nixGLDefault",
        ]
      }
    }
  '';
in
pkgs.writeShellScriptBin "run-fedora-vm" ''
  # Check if VM image exists, if not, build it
  if [ ! -f "${vmImage}" ]; then
    echo "VM image not found. Building it now..."
    
    # Generate the Kickstart file
    ${generateKickstartScript}/bin/generate-kickstart
    
    # Clean up existing output directory
    rm -rf output-fedora-vm
    
    ${vmUtils.cleanupVM vmName}

    ${pkgs.packer}/bin/packer init ${fedoraVmHcl}
    ${pkgs.packer}/bin/packer build ${fedoraVmHcl}
    
    # Check if build was successful
    if [ ! -f "${vmImage}" ]; then
      echo "Failed to build VM image. Exiting."
      exit 1
    fi
  fi

  ${vmUtils.createAndStartVM {
    inherit vmName vmImage userConfig;
    osVariant = "fedora37";
  }}
''
