{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.editors;
in
{
  options.hydenix.hm.editors = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable text editors module";
    };

    vscode = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable vscode";
      };

      wallbash = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable wallbash extension for vscode";
      };
    };

    neovim = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable neovim";
    };

    vim = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable vim";
    };

    default = lib.mkOption {
      type = lib.types.str;
      default = "vim";
      description = "Default text editor";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (lib.mkIf cfg.vim vim) # terminal text editor
      (lib.mkIf cfg.neovim neovim) # terminal text editor
      (lib.mkIf cfg.vscode.enable (
        vscode-with-extensions.override {
          vscodeExtensions = [
            # Use a conditional list instead of mkIf inside the list
          ] ++ lib.optionals cfg.vscode.wallbash [ pkgs.hydenix.code-wallbash ];
        }
      )) # gui text editor
    ];

    home.file = lib.mkIf cfg.vscode.enable {
      # Editor flags
      ".config/code-flags.conf".source =
        lib.mkDefault "${pkgs.hydenix.hyde}/Configs/.config/code-flags.conf";
      ".config/vscodium-flags.conf".source =
        lib.mkDefault "${pkgs.hydenix.hyde}/Configs/.config/vscodium-flags.conf";

      # VS Code settings
      ".config/Code - OSS/User/settings.json" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/Code - OSS/User/settings.json";
        force = true;
        mutable = true;
      };
      ".config/Code/User/settings.json" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/Code/User/settings.json";
        force = true;
        mutable = true;
      };
      ".config/VSCodium/User/settings.json" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/VSCodium/User/settings.json";
        force = true;
        mutable = true;
      };
    };

    home.sessionVariables = {
      EDITOR = cfg.default;
      VISUAL = cfg.default;
    };
  };
}
