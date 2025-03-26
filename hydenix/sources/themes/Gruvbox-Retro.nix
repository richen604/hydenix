{ pkgs, mkTheme }:
mkTheme rec {
  name = "Gruvbox Retro";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Gruvbox-Retro";
    name = name;
    sha256 = "sha256-zbY//EeJb9QelM+NNtzH58QcD8LGmgxmwQUvQ4eb554=";
  };
  meta = {
    description = "HyDE Theme: Gruvbox Retro";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Gruvbox-Retro";
    priority = 100;
  };
}
