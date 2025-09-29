{ pkgs, mkTheme }:
mkTheme rec {
  name = "Pixel Dream";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Pixel-Dream";
    rev = "79607bbf37c356acb80992c8302ada3336f9d8fa";
    name = name;
    sha256 = "sha256-uuqktN19CBY8EDleC+8U/vXrPgwH/lStS8G6hyN+fWE=";
  };
  meta = {
    description = "Pixel Art inspired theme";
    homepage = "https://github.com/rishav12s/Pixel-Dream";
    priority = 10;
  };
}
