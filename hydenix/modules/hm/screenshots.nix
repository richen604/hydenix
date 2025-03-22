{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.screenshots;
in
{
  options.hydenix.hm.screenshots = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable screenshots module";
    };

    grim = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable grim screenshot tool";
      };
    };

    slurp = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable slurp region selection tool";
      };
    };

    satty = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable satty screenshot annotation tool";
      };
    };

    swappy = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable swappy screenshot editor";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (lib.mkIf cfg.grim.enable grim) # screenshot tool
      (lib.mkIf cfg.slurp.enable slurp) # region selection tool
      (lib.mkIf cfg.satty.enable satty) # screenshot annotation tool
      (lib.mkIf cfg.swappy.enable swappy) # screenshot editor
    ];
  };
}
