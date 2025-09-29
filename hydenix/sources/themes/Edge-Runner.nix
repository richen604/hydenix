{ pkgs, mkTheme }:
mkTheme rec {
  name = "Edge Runner";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "969a71e3c8de0d22dfba82b8b2fb8daa2dca50a7";
    name = name;
    sha256 = "sha256-wbIIczb2/sVJe97oVFkLxmVf+BwYOlq4aQwDB3x7G2I=";
  };
  meta = {
    description = "HyDE Theme: Edge Runner";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Edge-Runner";
    priority = 100;
  };
}
