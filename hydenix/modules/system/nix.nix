{
  config,
  lib,
  ...
}:

let
  cfg = config.hydenix.nix;
in
{
  options.hydenix.nix = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable nix module";
    };
  };

  config = lib.mkIf cfg.enable {
    nix = {
      settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = [
          "https://cache.nixos.org"
          "https://hyprland.cachix.org"
          "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };
  };
}
