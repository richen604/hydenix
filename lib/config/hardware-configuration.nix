{
  # Minimal hardware configuration for checks
  fileSystems."/" = {
    device = "/dev/null";
    fsType = "ext4";
  };
  boot.loader.grub.device = "/dev/null";
}
