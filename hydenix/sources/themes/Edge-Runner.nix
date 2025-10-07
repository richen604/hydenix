{ pkgs, mkTheme }:
mkTheme rec {
  name = "Edge Runner";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Edge-Runner";
    name = name;
    sha256 = "sha256-wbIIczb2/sVJe97oVFkLxmVf+BwYOlq4aQwDB3x7G2I=";
  };
  meta = {
    description = "HyDE Theme: Edge Runner";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Edge-Runner";
    priority = 100;
  };
}
