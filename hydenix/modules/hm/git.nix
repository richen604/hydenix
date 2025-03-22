{ lib, config, ... }:

let
  cfg = config.hydenix.hm.git;
in
{

  options.hydenix.hm.git = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable git module";
    };

    name = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Git user name";
    };

    email = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Git user email";
    };
  };

  config = lib.mkIf cfg.enable {

    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.email;
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };
  };
}
