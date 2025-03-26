{ pkgs, mkTheme }:
mkTheme rec {
  name = "Catppuccin Mocha";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Catppuccin-Mocha";
    name = name;
    sha256 = "sha256-F4ounl97JN8AuIo4ikO/hF/Zsrq7I1hGc9ZzobFiVPA=";
  };
  meta = {
    description = "HyDE Theme: Catppuccin Mocha";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Catppuccin-Mocha";
    priority = 100;
  };
}
