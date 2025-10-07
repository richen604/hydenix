{ pkgs, mkTheme }:
mkTheme rec {
  name = "Bad Blood";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-gallery";
    name = name;
    rev = "Bad-Blood";
    sha256 = "sha256-MbHgUbKNN1o72QLPehdcyI22lwBDoWy2G58lgHBFeZ4=";
  };
  meta = {
    description = "HyDE Theme: Bad Blood";
    homepage = "https://github.com/HyDE-Project/hyde-gallery/tree/Bad-Blood";
    priority = 10;
  };
}
