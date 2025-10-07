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
        ffec = "_fuzzy_edit_search_file_content";
        ffcd = "_fuzzy_change_directory";
        ffe = "_fuzzy_edit_search_file";
        df = "_df";
      };

      # Using the new initContent API with proper ordering
      initContent = lib.mkMerge [
        # Early initialization (before completion init) - order 550
        (lib.mkOrder 550 ''
          #!/usr/bin/env zsh
          function no_such_file_or_directory_handler {
              local red='\e[1;31m' reset='\e[0m'
              printf "''${red}zsh: no such file or directory: %s''${reset}\n" "$1"
              return 127
          }

          # best fzf aliases ever
          _fuzzy_change_directory() {
              local initial_query="$1"
              local selected_dir
              local fzf_options=('--preview=ls -p {}' '--preview-window=right:60%')
              fzf_options+=(--height "80%" --layout=reverse --preview-window right:60% --cycle)
              local max_depth=7

              if [[ -n "$initial_query" ]]; then
                  fzf_options+=("--query=$initial_query")
              fi

              #type -d
              selected_dir=$(find . -maxdepth $max_depth \( -name .git -o -name node_modules -o -name .venv -o -name target -o -name .cache \) -prune -o -type d -print 2>/dev/null | fzf "''${fzf_options[@]}")

              if [[ -n "$selected_dir" && -d "$selected_dir" ]]; then
                  cd "$selected_dir" || return 1
              else
                  return 1
              fi
          }

          _fuzzy_edit_search_file_content() {
              # [f]uzzy [e]dit  [s]earch [f]ile [c]ontent
              local selected_file
              selected_file=$(grep -irl "''${1:-}" ./ | fzf --height "80%" --layout=reverse --preview-window right:60% --cycle --preview 'cat {}' --preview-window right:60%)

              if [[ -n "$selected_file" ]]; then
                  if command -v "$EDITOR" &>/dev/null; then
                      "$EDITOR" "$selected_file"
                  else
                      echo "EDITOR is not specified. using vim.  (you can export EDITOR in ~/.zshrc)"
                      vim "$selected_file"
                  fi
              else
                  echo "No file selected or search returned no results."
              fi
          }

          _fuzzy_edit_search_file() {
              local initial_query="$1"
              local selected_file
              local fzf_options=()
              fzf_options+=(--height "80%" --layout=reverse --preview-window right:60% --cycle)
              local max_depth=5

              if [[ -n "$initial_query" ]]; then
                  fzf_options+=("--query=$initial_query")
              fi

              # -type f: only find files
              selected_file=$(find . -maxdepth $max_depth -type f 2>/dev/null | fzf "''${fzf_options[@]}")

              if [[ -n "$selected_file" && -f "$selected_file" ]]; then
                  if command -v "$EDITOR" &>/dev/null; then
                      "$EDITOR" "$selected_file"
                  else
                      echo "EDITOR is not specified. using vim.  (you can export EDITOR in ~/.zshrc)"
                      vim "$selected_file"
                  fi
              else
                  return 1
              fi
          }

          _df() {
              if [[ $# -ge 1 && -e "''${@: -1}" ]]; then
                  duf "''${@: -1}"
              else
                  duf
              fi
          }

          # Some binds won't work on first prompt when deferred
          bindkey '\e[H' beginning-of-line
          bindkey '\e[F' end-of-line
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
        ".config/zsh/functions/error-handlers.zsh".source =
          "${pkgs.hyde}/Configs/.config/zsh/functions/error-handlers.zsh";
        ".config/zsh/functions/eza.zsh".source = "${pkgs.hyde}/Configs/.config/zsh/functions/eza.zsh";
        ".config/zsh/functions/fzf.zsh".source = "${pkgs.hyde}/Configs/.config/zsh/functions/fzf.zsh";
        ".config/zsh/functions/kb_help.zsh".source =
          "${pkgs.hyde}/Configs/.config/zsh/functions/kb_help.zsh";

        # We are not including any of these configurations as they are part of the existing zsh options
        # ".config/zsh/.zshenv".source = "${pkgs.hyde}/Configs/.config/zsh/.zshenv";
        # ".config/zsh/user.zsh".source = "${pkgs.hyde}/Configs/.config/zsh/user.zsh";
        # ".config/zsh/prompt.zsh".source = "${pkgs.hyde}/Configs/.config/zsh/prompt.zsh";
        # ".config/zsh/conf.d/hyde/terminal.zsh".source = "${pkgs.hyde}/Configs/.config/zsh/conf.d/hyde/terminal.zsh";
        # ".config/zsh/conf.d/00-hyde.zsh".source = "${pkgs.hyde}/Configs/.config/zsh/conf.d/00-hyde.zsh";
        # ".config/zsh/conf.d/hyde/env.zsh".source = "${pkgs.hyde}/Configs/.config/zsh/conf.d/hyde/env.zsh";
        # ".config/zsh/conf.d/hyde/prompt.zsh".source = "${pkgs.hyde}/Configs/.config/zsh/conf.d/hyde/prompt.zsh";
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
