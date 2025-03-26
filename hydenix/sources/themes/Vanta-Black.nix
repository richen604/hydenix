{ pkgs, mkTheme }:
mkTheme rec {
  name = "Vanta Black";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Vanta-Black";
    rev = "e8ef0d6b8b1a13e7b471f3c803bb96bd46cb4837";
    name = name;
    sha256 = "sha256-d62aHzryeBnrSvam0K3GGRdIu2ViJXoVws+YEY6ZHA0=";
  };
  meta = {
    description = "HyDE Theme: Vanta Black inspired theme having the deepest blacks";
    homepage = "https://github.com/rishav12s/Vanta-Black";
    priority = 10;
  };
}
