{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.hyprland;
in
{
  imports = [
    ./options.nix
    ./assertions.nix
    ./animations.nix
    ./shaders.nix
    ./workflows.nix
    ./hypridle.nix
    ./keybindings.nix
    ./windowrules.nix
    ./nvidia.nix
    ./monitors.nix
  ];

  config = lib.mkIf cfg.enable {
    # Always include packages and base setup
    home.packages = with pkgs; [
      hyprcursor
      hyprutils
      xdg-desktop-portal-hyprland
      hyprpicker
      hypridle
    ];

    home.activation.createHyprConfigs = lib.hm.dag.entryAfter [ "mutableGeneration" ] ''
      mkdir -p "$HOME/.config/hypr/animations"
      mkdir -p "$HOME/.config/hypr/themes"
      mkdir -p "$HOME/.config/hypr/shaders"
      mkdir -p "$HOME/.config/hypr/workflows"

      touch "$HOME/.config/hypr/animations/theme.conf"
      touch "$HOME/.config/hypr/themes/colors.conf"
      touch "$HOME/.config/hypr/themes/theme.conf"
      touch "$HOME/.config/hypr/themes/wallbash.conf"

      chmod 644 "$HOME/.config/hypr/animations/theme.conf"
      chmod 644 "$HOME/.config/hypr/themes/colors.conf"
      chmod 644 "$HOME/.config/hypr/themes/theme.conf"
      chmod 644 "$HOME/.config/hypr/themes/wallbash.conf"
    '';

    home.file = {
      ".config/hypr/hyprland.conf" =
        if cfg.overrideMain != null then
          {
            text = cfg.overrideMain;
            force = true;
          }
        else
          {
            source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/hyprland.conf";
            force = true;
          };

      ".config/hypr/hyde.conf".source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/hyde.conf";

      ".config/hypr/userprefs.conf" = {
        text = cfg.extraConfig;
        force = true;
      };
    };
  };
}
