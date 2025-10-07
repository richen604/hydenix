{ pkgs, mkTheme }:
mkTheme rec {
  name = "Catppuccin Latte";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "9a9332bb660ecb2e05671b7dcd7dd058b0803e48";
    name = name;
    sha256 = "sha256-dW5DgXFxFNjt54Styzk+Ew3pv4rO1FX/qtfDGIClLuY=";
  };
  meta = {
    description = "HyDE Theme: Catppuccin Latte";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Catppuccin-Latte";
  };
}
