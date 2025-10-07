{ pkgs, mkTheme }:
mkTheme rec {
  name = "Gruvbox Retro";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "a00ab7d183c877152c997fdac5d877a38dea30f1";
    name = name;
    sha256 = "sha256-GJ3Y9b36mPZMzzIlBx6S862KS3mOB9ItCKIZf5qKIeo=";
  };
  meta = {
    description = "HyDE Theme: Gruvbox Retro";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Gruvbox-Retro";
    priority = 100;
  };
}
