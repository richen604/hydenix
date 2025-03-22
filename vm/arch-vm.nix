{ pkgs, userConfig, ... }:

let
  vmUtils = import ./vm-utils.nix { inherit pkgs; };
  vmName = "arch-vm";
  vmImage = "output-arch-vm/arch-vm";

  archVmHcl = pkgs.writeText "arch-vm.pkr.hcl" ''
    packer {
      required_plugins {
        qemu = {
          version = ">= 1.0.0"
          source  = "github.com/hashicorp/qemu"
        }
      }
    }

    source "qemu" "arch" {
      iso_url           = "https://geo.mirror.pkgbuild.com/iso/latest/archlinux-x86_64.iso"
      iso_checksum      = "file:https://geo.mirror.pkgbuild.com/iso/latest/sha256sums.txt"
      output_directory  = "output-arch-vm"
      shutdown_command  = "echo 'packer' | sudo -S shutdown -P now"
      disk_size         = "${toString userConfig.vm.diskSize}"
      format            = "qcow2"
      accelerator       = "kvm"
      ssh_username      = "${userConfig.username}"
      ssh_password      = "${userConfig.defaultPassword}"
      ssh_timeout       = "20m"
      vm_name           = "arch-vm"
      memory            = "${toString userConfig.vm.memorySize}"
      cpus              = "${toString userConfig.vm.cores}"
      headless          = false
      boot_wait         = "8s"
      boot_command      = [
        "<enter><wait15><wait15>",
        "/usr/bin/curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/arch-preseed.sh<enter><wait5>",
        "/usr/bin/bash arch-preseed.sh<enter>"
      ]
      http_directory    = "${toString ./.}/scripts/preseed"
      ssh_handshake_attempts = "20"
    }

    build {
      sources = ["source.qemu.arch"]

      provisioner "shell" {
        inline = [
          "sudo pacman -Syu --noconfirm",
          "sudo pacman -S --noconfirm base-devel git vim",
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
          "mkdir -p /home/${userConfig.username}/hydenix"
        ]
      }

      provisioner "file" {
        source      = "${toString ./.}/../../"
        destination = "/home/${userConfig.username}/hydenix"
      }

      provisioner "shell" {
        script = "${toString ./.}/scripts/install/arch-setup.sh"
      }

      provisioner "shell" {
        inline = [
          "cd /home/${userConfig.username}/hydenix",
          ". /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh",
          "nix run home-manager/master -- switch --flake .#${userConfig.username}-generic",
          "nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update",
          "nix-env -iA nixgl.auto.nixGLDefault",
        ]
      }

    }
  '';
in
pkgs.writeShellScriptBin "run-arch-vm" ''
  # Check if VM image exists, if not, build it
  if [ ! -f "${vmImage}" ]; then
    echo "VM image not found. Building it now..."
    
    # Clean up existing output directory
    rm -rf output-arch-vm
    
    ${vmUtils.cleanupVM vmName}

    ${pkgs.packer}/bin/packer init ${archVmHcl}
    ${pkgs.packer}/bin/packer build ${archVmHcl}
    
    # Check if build was successful
    if [ ! -f "${vmImage}" ]; then
      echo "Failed to build VM image. Exiting."
      exit 1
    fi
  fi

  ${vmUtils.createAndStartVM {
    inherit vmName vmImage userConfig;
    osVariant = "archlinux";
  }}
''
