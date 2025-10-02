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
      plugins = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [
          "sudo"
        ];
        description = "Zsh plugins to enable";
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

    p10k = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable p10k shell";
      };
    };

    starship = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable starship shell";
      };
    };

    pokego = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Pokemon ASCII art scripts on shell startup";
      };
    };

    fastfetch = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable fastfetch on shell startup";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        fastfetch
      ]
      ++ lib.optionals (cfg.zsh.enable || cfg.fish.enable) [
        eza
        duf
        bat
      ]
      ++ lib.optionals cfg.zsh.enable [
        zsh
        oh-my-zsh
        zsh-autosuggestions
        zsh-syntax-highlighting
      ]
      ++ lib.optionals cfg.bash.enable [ bash ]
      ++ lib.optionals cfg.fish.enable [ fish ]
      ++ lib.optionals cfg.pokego.enable [ pokego ]
      ++ lib.optionals cfg.starship.enable [ starship ]
      ++ lib.optionals cfg.p10k.enable [ zsh-powerlevel10k ];

    programs.zsh = lib.mkIf cfg.zsh.enable {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = cfg.zsh.plugins;
      };
      dotDir = "${config.xdg.configHome}/zsh";

      # Custom shell aliases integrated into programs.zsh
      shellAliases = {
        c = "clear";
        vc = "code";
        fastfetch = "fastfetch --logo-type kitty";
        ".." = "cd ..";
        "..." = "cd ../..";
        ".3" = "cd ../../..";
        ".4" = "cd ../../../..";
        ".5" = "cd ../../../../..";
        mkdir = "mkdir -p";
      };

      # Using the new initContent API with proper ordering
      initContent = lib.mkMerge [
        # Early initialization (before completion init) - order 550
        (lib.mkOrder 550 ''
          #!/usr/bin/env zsh
          # Some binds won't work on first prompt when deferred
          bindkey '\e[H' beginning-of-line
          bindkey '\e[F' end-of-line
        '')

        # needs to be sourced after 550
        (lib.mkOrder 910 ''
          # Source the rest of the functions
          if [[ -d ~/.config/zsh/functions ]]; then
              for file in ~/.config/zsh/functions/*.zsh; do
                  [[ -f "$file" ]] && source "$file"
              done
          fi

          if [[ -d ~/.config/zsh/completions ]]; then
              for file in ~/.config/zsh/completions/*.zsh; do
                  [[ -f "$file" ]] && source "$file"
              done
          fi
        '')

        # Regular initialization content
        ''
          ${lib.optionalString cfg.pokego.enable ''
            pokego --no-title -r 1,3,6
          ''}
          ${lib.optionalString cfg.starship.enable ''
            eval "$(${pkgs.starship}/bin/starship init zsh)"
            export STARSHIP_CACHE=$XDG_CACHE_HOME/starship
            export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
          ''}
          ${lib.optionalString cfg.p10k.enable ''
            # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
             # Initialization code that may require console input (password prompts, [y/n]
             # confirmations, etc.) must go above this block; everything else may go below.
             if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
               source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
             fi
             source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          ''}
          ${lib.optionalString cfg.fastfetch.enable ''
            fastfetch --logo-type kitty
          ''}
          ${cfg.zsh.configText}
        ''
      ];
    };

    programs.fish = lib.mkIf cfg.fish.enable {
      enable = true;
      #reimpementing the HyDE-Project config.fish using home.manager
      interactiveShellInit = ''
        # Disable greeting
        set -g fish_greeting

        # Source Hyde configuration
        source ${pkgs.hyde}/Configs/.config/fish/conf.d/hyde.fish
        source ${pkgs.hyde}/Configs/.config/fish/user.fish

        ${lib.optionalString cfg.starship.enable ''
          if type -q starship
            starship init fish | source
            set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship
            set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/starship.toml
          end
        ''}

        # fzf
        if type -q fzf
            fzf --fish | source
            for file in ~/.config/fish/functions/fzf/*.fish
                source $file
                # NOTE: these funtions are built on top of fzf builtin widgets
                # they help you navigate through directories and files "Blazingly" fast
                # to get help on each one, just type `ff` in terminal and press `TAB`
                # keep in mind all of them require an argument to be passed after the alias
            end
        end

        # NOTE: binds Alt+n to inserting the nth command from history in edit buffer
        # e.g. Alt+4 is same as pressing Up arrow key 4 times
        # really helpful if you get used to it
        bind_M_n_history

        # example integration with bat : <cltr+f>
        # bind -M insert \ce '$EDITOR $(fzf --preview="bat --color=always --plain {}")'

        set fish_pager_color_prefix cyan
        set fish_color_autosuggestion brblack

        # List Directory
        alias c='clear'
        alias l='eza -lh --icons=auto'
        alias ls='eza -1 --icons=auto'
        alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
        alias ld='eza -lhD --icons=auto'
        alias lt='eza --icons=auto --tree'
        alias un='$aurhelper -Rns'
        alias up='$aurhelper -Syu'
        alias pl='$aurhelper -Qs'
        alias pa='$aurhelper -Ss'
        alias pc='$aurhelper -Sc'
        alias po='$aurhelper -Qtdq | $aurhelper -Rns -'
        alias vc='code'
        alias fastfetch='fastfetch --logo-type kitty'

        # Directory navigation shortcuts
        alias ..='cd ..'
        alias ...='cd ../..'
        alias .3='cd ../../..'
        alias .4='cd ../../../..'
        alias .5='cd ../../../../..'

        abbr mkdir 'mkdir -p'

        ${lib.optionalString cfg.pokego.enable ''
          pokego --no-title -r 1,3,6
        ''}

        ${lib.optionalString cfg.fastfetch.enable ''
          fastfetch --logo-type kitty
        ''}
      '';
      shellAliases = {
        l = "eza -lh --icons=auto";
        ls = "eza -1 --icons=auto";
        ll = "eza -lha --icons=auto --sort=name --group-directories-first";
        ld = "eza -lhD --icons=auto";
        lt = "eza --icons=auto --tree";
        vc = "code";
      };
      shellAbbrs = {
        ".." = "cd ..";
        "..." = "cd ../..";
        ".3" = "cd ../../..";
        ".4" = "cd ../../../..";
        ".5" = "cd ../../../../..";
        mkdir = "mkdir -p";
      };
    };

    home.file = lib.mkMerge [
      (lib.mkIf cfg.zsh.enable {
        # Zsh configs
        ".zshenv".source = "${pkgs.hyde}/Configs/.zshenv";
        ".config/zsh/completions/hyde-shell.zsh".source =
          "${pkgs.hyde}/Configs/.config/zsh/completions/hyde-shell.zsh";
        ".config/zsh/.p10k.zsh" = {
          source = "${pkgs.hyde}/Configs/.config/zsh/.p10k.zsh";
          enable = cfg.p10k.enable;
        };
        ".config/zsh/completions/fzf.zsh".source = "${pkgs.hyde}/Configs/.config/zsh/completions/fzf.zsh";
        ".config/zsh/completions/hydectl.zsh".source =
          "${pkgs.hyde}/Configs/.config/zsh/completions/hydectl.zsh";
        ".config/zsh/functions/bat.zsh".source = "${pkgs.hyde}/Configs/.config/zsh/functions/bat.zsh";
        ".config/zsh/functions/bind_M_n_history.zsh".source =
          "${pkgs.hyde}/Configs/.config/zsh/functions/bind_M_n_history.zsh";
        ".config/zsh/functions/duf.zsh".source = "${pkgs.hyde}/Configs/.config/zsh/functions/duf.zsh";
        ".config/zsh/functions/eza.zsh".source = "${pkgs.hyde}/Configs/.config/zsh/functions/eza.zsh";
        ".config/zsh/functions/fzf.zsh".source = "${pkgs.hyde}/Configs/.config/zsh/functions/fzf.zsh";
        ".config/zsh/functions/kb_help.zsh".source =
          "${pkgs.hyde}/Configs/.config/zsh/functions/kb_help.zsh";

        # We are not including any of these configurations as they are part of the existing zsh home-manager options
        # ".config/zsh/functions/error-handlers.zsh".source = "${pkgs.hydenix.hyde}/Configs/.config/zsh/functions/error-handlers.zsh";
        # ".config/zsh/functions/fzf.zsh".source = "${pkgs.hydenix.hyde}/Configs/.config/zsh/functions/fzf.zsh";
        # ".config/zsh/.zshenv".source = "${pkgs.hydenix.hyde}/Configs/.config/zsh/.zshenv";
        # ".config/zsh/user.zsh".source = "${pkgs.hydenix.hyde}/Configs/.config/zsh/user.zsh";
        # ".config/zsh/prompt.zsh".source = "${pkgs.hydenix.hyde}/Configs/.config/zsh/prompt.zsh";
        # ".config/zsh/conf.d/hyde/terminal.zsh".source = "${pkgs.hydenix.hyde}/Configs/.config/zsh/conf.d/hyde/terminal.zsh";
        # ".config/zsh/conf.d/00-hyde.zsh".source = "${pkgs.hydenix.hyde}/Configs/.config/zsh/conf.d/00-hyde.zsh";
        # ".config/zsh/conf.d/hyde/env.zsh".source = "${pkgs.hydenix.hyde}/Configs/.config/zsh/conf.d/hyde/env.zsh";
        # ".config/zsh/conf.d/hyde/prompt.zsh".source = "${pkgs.hydenix.hyde}/Configs/.config/zsh/conf.d/hyde/prompt.zsh";
      })
      (lib.mkIf cfg.fish.enable {
        # Fish configs
        ".config/fish/completions/hyde-shell.fish".source =
          "${pkgs.hyde}/Configs/.config/fish/completions/hyde-shell.fish";
        ".config/fish/conf.d/hyde.fish".source = "${pkgs.hyde}/Configs/.config/fish/conf.d/hyde.fish";
        ".config/fish/functions/bind_M_n_history.fish".source =
          "${pkgs.hyde}/Configs/.config/fish/functions/bind_M_n_history.fish";
        ".config/fish/functions/fzf/ffcd.fish".source =
          "${pkgs.hyde}/Configs/.config/fish/functions/fzf/ffcd.fish";
        ".config/fish/functions/fzf/ffch.fish".source =
          "${pkgs.hyde}/Configs/.config/fish/functions/fzf/ffch.fish";
        ".config/fish/functions/fzf/ffec.fish".source =
          "${pkgs.hyde}/Configs/.config/fish/functions/fzf/ffec.fish";
        ".config/fish/functions/fzf/ffe.fish".source =
          "${pkgs.hyde}/Configs/.config/fish/functions/fzf/ffe.fish";
        ".config/fish/user.fish".source = "${pkgs.hyde}/Configs/.config/fish/user.fish";
      })

      # LSD configs - these are always included
      {
        ".config/lsd/config.yaml".source = "${pkgs.hyde}/Configs/.config/lsd/config.yaml";
        ".config/lsd/icons.yaml".source = "${pkgs.hyde}/Configs/.config/lsd/icons.yaml";
        ".config/lsd/colors.yaml".source = "${pkgs.hyde}/Configs/.config/lsd/colors.yaml";
      }

      (lib.mkIf cfg.starship.enable {
        ".config/starship/powerline.toml".source = "${pkgs.hyde}/Configs/.config/starship/powerline.toml";
        ".config/starship/starship.toml".source = "${pkgs.hyde}/Configs/.config/starship/starship.toml";
      })
    ];
  };
}
