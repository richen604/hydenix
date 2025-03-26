{ pkgs, mkTheme }:
mkTheme rec {
  name = "Graphite Mono";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Graphite-Mono";
    name = name;
    sha256 = "sha256-WwEjLynHrLLB91MMTPZKsCMk7OAdKPw4Do7DjbpjQbo=";
  };
  meta = {
    description = "HyDE Theme: Graphite Mono";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Graphite-Mono";
    priority = 90;
  };
}
