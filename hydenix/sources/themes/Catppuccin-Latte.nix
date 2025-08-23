{ pkgs, mkTheme }:
mkTheme rec {
  name = "Catppuccin Latte";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Catppuccin-Latte";
    name = name;
    sha256 = "sha256-dW5DgXFxFNjt54Styzk+Ew3pv4rO1FX/qtfDGIClLuY=";
  };
  meta = {
    priority = 100;
    description = "HyDE Theme: Catppuccin Latte";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Catppuccin-Latte";
  };
}
