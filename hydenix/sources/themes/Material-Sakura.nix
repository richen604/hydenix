{ pkgs, mkTheme }:
mkTheme rec {
  name = "Material Sakura";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Material-Sakura";
    name = name;
    sha256 = "sha256-pxVWKIxjLKoTUbRBrAn9SludTLyS+yA5HlqyFRLHdiM=";
  };
  meta = {
    description = "HyDE Theme: Material Sakura";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Material-Sakura";
    priority = 95;
  };
}
