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
            diskSize = 20480;
            qemu = {
              options = [
                "-device virtio-vga-gl,xres=2056,yres=1440"
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

          # Console font for readable CLI recordings at 1440p (2K)
          console = {
            earlySetup = true;
            packages = [ pkgs.terminus_font ];
            font = "ter-v32b";
          };

          # # Use kmscon for TTF Nerd Font rendering on the console
          # services.kmscon = {
          #   enable = true;
          #   hwRender = true;
          #   fonts = [
          #     {
          #       package = pkgs.nerd-fonts.jetbrains-mono;
          #       name = "JetBrainsMono Nerd Font Mono";
          #     }
          #   ];
          #   extraConfig = ''
          #     font-size=36
          #   '';
          # };

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
