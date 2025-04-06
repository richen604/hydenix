{ hydenix-inputs, ... }:
let
  # Define pkgs for easier access
  pkgs = import hydenix-inputs.hydenix-nixpkgs {
    inherit (hydenix-inputs.lib) system;
    config.allowUnfree = true;
  };

  # Import the ISO configuration
  isoConfig = (
    import ../iso/default.nix {
      inherit hydenix-inputs;
    }
  );

  # Get the actual path to the ISO image file
  isoPath = "${isoConfig.isoSystem.config.system.build.isoImage}/iso/hydenix.iso";

  # TODO: needs uefi bootloader
  # TODO: fix resolution/display
in
# Instead of a NixOS system, create a direct VM script
pkgs.writeShellScriptBin "run-demo-vm" ''
  QEMU=${pkgs.qemu}/bin/qemu-system-x86_64

  # Create a virtual disk if it doesn't exist yet
  if [ ! -f ./nixos-disk.qcow2 ]; then
    ${pkgs.qemu}/bin/qemu-img create -f qcow2 ./nixos-disk.qcow2 30G
  fi

  # Run QEMU with the ISO as boot device
  $QEMU \
    -enable-kvm \
    -m 8192 \
    -smp 6 \
    -cpu host \
    -machine q35,accel=kvm \
    -drive file=./nixos-disk.qcow2,if=virtio,cache=writeback \
    -drive media=cdrom,file=${isoPath},readonly=on \
    -boot d \
    -device virtio-vga-gl \
    -display gtk,gl=on,grab-on-hover=on \
    -usb -device usb-tablet \
    -device intel-iommu \
    -device ich9-intel-hda \
    -device hda-output \
''
