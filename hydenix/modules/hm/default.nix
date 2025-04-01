{
  lib,
  ...
}:

{
  imports = [
    ./mutable.nix
    ./comma.nix
    ./dolphin.nix
    ./editors.nix
    ./fastfetch.nix
    ./firefox.nix
    ./gtk.nix
    ./git.nix
    ./hyde.nix
    ./hyprland.nix
    ./lockscreen.nix
    ./notifications.nix
    ./qt.nix
    ./rofi.nix
    ./screenshots.nix
    ./shell.nix
    ./social.nix
    ./spotify.nix
    ./swww.nix
    ./terminals.nix
    ./theme.nix
    ./waybar.nix
    ./wlogout.nix
    ./xdg.nix
  ];

  options.hydenix.hm = {
    enable = lib.mkEnableOption "Enable Hydenix home-manager modules globally";
  };

  config = {
    hydenix.hm.enable = lib.mkDefault false;
    home.stateVersion = "25.05";
  };

}
