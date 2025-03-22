{ pkgs, mkTheme }:
mkTheme rec {
  name = "Catppuccin Latte";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Catppuccin-Latte";
    name = name;
    sha256 = "sha256-lIxkf/3zXimt1lYfj5Vt6uks4L9IhYUFJM7b9H7UniY=";
  };

  arcs = {
    gtk = "Catppuccin-Latte";
    icon = "Tela-circle-grey";
  };

  meta = {
    priority = 100;
    description = "HyDE Theme: Catppuccin Latte";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Catppuccin-Latte";
  };
}
