{ hydenix-inputs, ... }:
hydenix-inputs.hydenix-nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    (
      { config, pkgs, ... }:
      {
        virtualisation.vmVariant = {
          virtualisation.forwardPorts = [
            {
              from = "host";
              host.port = 2222;
              guest.port = 22;
            }
          ];
          virtualisation = {
            memorySize = 8192;
            cores = 6;
            diskSize = 102400;
            qemu = {
              options = [
                "-device virtio-vga-gl"
                "-display gtk,gl=on,grab-on-hover=on"
                "-usb -device usb-tablet"
                "-cpu host"
                "-enable-kvm"
                "-vga none"
              ];
            };
          };
          services.xserver = {
            videoDrivers = [ "virtio" ];
          };

          system.stateVersion = "25.05";
        };

        # Create nixos user with password
        users.users.nixos = {
          isNormalUser = true;
          description = "NixOS User";
          extraGroups = [
            "wheel"
            "networkmanager"
            "video"
          ];
          # To set a password, run: mkpasswd -m sha-512
          # Or use this temporary password (change on first login)
          initialPassword = "nixos";
        };

        # Enable SSH server
        services.openssh = {
          enable = true;
          settings = {
            PermitRootLogin = "no";
            PasswordAuthentication = true;
          };
        };

        # Enable flakes
        nix = {
          extraOptions = ''
            experimental-features = nix-command flakes
          '';
          settings = {
            trusted-users = [
              "root"
              "@wheel"
            ];
            auto-optimise-store = true;
          };
        };

        environment.systemPackages = with pkgs; [
          open-vm-tools
          spice-gtk
          spice-vdagent
          git # Required for flakes
        ];
        services.qemuGuest.enable = true;
        services.spice-vdagentd.enable = true;
        hardware.graphics.enable = true;
      }
    )
  ];
}
