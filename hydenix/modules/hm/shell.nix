{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.shell;
in
{
  options.hydenix.hm.shell = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable shell module";
    };

    zsh = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable zsh shell";
      };
      configText = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Zsh config multiline text, use this to extend zsh settings in .zshrc";
      };
    };

    bash = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable bash shell";
      };
    };

    fish = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable fish shell";
      };
    };
    pokego = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Pokemon ASCII art scripts";
      };
    };
  };

  config = lib.mkIf cfg.enable {

    home.packages =
      with pkgs;
      [
        fastfetch
      ]
      ++ lib.optionals cfg.zsh.enable [
        zsh
        eza
        oh-my-zsh
        zsh-powerlevel10k
        zsh-autosuggestions
        zsh-syntax-highlighting
      ]
      ++ lib.optionals cfg.bash.enable [ bash ]
      ++ lib.optionals cfg.fish.enable [ fish ]
      ++ lib.optionals cfg.pokego.enable [ pokego ];

    programs.zsh = lib.mkIf cfg.zsh.enable {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "sudo"
          "git"
        ];
      };
      initExtra = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      '';
      initExtraFirst = ''
        ${lib.optionalString cfg.pokego.enable ''
          pokego --no-title -r 1,3,6
        ''}
        # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
        # Initialization code that may require console input (password prompts, [y/n]
        # confirmations, etc.) must go above this block; everything else may go below.
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '';
    };

    home.file = lib.mkMerge [
      (lib.mkIf cfg.zsh.enable {
        # Shell configs
        ".zshrc".text = lib.mkDefault ''
          ${cfg.zsh.configText}
        '';

        # we are writing our own .zshenv file to ensure that its properly sourcing nix paths, and removes all the arch nonsense
        ".zshenv".text = lib.mkDefault ''
          #!/usr/bin/env zsh
          # HyDE's ZSH env configuration
          # This file is sourced by ZSH on startup
          # And ensures that we have an obstruction free ~/.zshrc file
          # This also ensures that the proper HyDE $ENVs are loaded

          # Function to handle initialization errors
          function handle_init_error {
              if [[ $? -ne 0 ]]; then
                  echo "Error during initialization. Please check your configuration."
              fi
          }

          function no_such_file_or_directory_handler {
              local red='\e[1;31m' reset='\e[0m'
              printf "''${red}zsh: no such file or directory: %s''${reset}\n" "$1"
              return 127
          }

          if [ -t 1 ];then
              # We are loading the prompt on start so users can see the prompt immediately
              # Powerlevel10k theme path
              P10k_THEME=''${P10k_THEME:-${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme}
              [[ -r $P10k_THEME ]] && source $P10k_THEME

              # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
              [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

              # Optionally load user configuration // usefull for customizing the shell without modifying the main file
              [[ -f ~/.hyde.zshrc ]] && source ~/.hyde.zshrc

              # Helpful aliases
              if [[ -x "$(which eza)" ]]; then
                  alias ls='eza' \
                      l='eza -lh --icons=auto' \
                      ll='eza -lha --icons=auto --sort=name --group-directories-first' \
                      ld='eza -lhD --icons=auto' \
                      lt='eza --icons=auto --tree'
              fi

              alias c='clear' \
                  vc='code' \
                  fastfetch='fastfetch --logo-type kitty' \
                  ..='cd ..' \
                  ...='cd ../..' \
                  .3='cd ../../..' \
                  .4='cd ../../../..' \
                  .5='cd ../../../../..' \
                  mkdir='mkdir -p' # Always mkdir a path (this doesn't inhibit functionality to make a single dir)
          fi
        '';
        ".p10k.zsh".source = lib.mkDefault "${pkgs.hydenix.hyde}/Configs/.p10k.zsh";
      })

      (lib.mkIf cfg.fish.enable {
        # Fish configs
        ".config/fish/config.fish".source =
          lib.mkDefault "${pkgs.hydenix.hyde}/Configs/.config/fish/config.fish";
      })

      # LSD configs - these are always included
      {
        ".config/lsd/config.yaml".source =
          lib.mkDefault "${pkgs.hydenix.hyde}/Configs/.config/lsd/config.yaml";
        ".config/lsd/icons.yaml".source =
          lib.mkDefault "${pkgs.hydenix.hyde}/Configs/.config/lsd/icons.yaml";
        ".config/lsd/colors.yaml".source =
          lib.mkDefault "${pkgs.hydenix.hyde}/Configs/.config/lsd/colors.yaml";
      }
    ];
  };
}
