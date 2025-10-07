{ pkgs, mkTheme }:
mkTheme rec {
  name = "Greenify";
  src = pkgs.fetchFromGitHub {
    owner = "mahaveergurjar";
    repo = "Theme-Gallery";
    name = name;
    rev = "Greenify";
    sha256 = "sha256-jf8CilUopQBqAa3JBPl68S9P7Hg/87KpyEATbiOhg4A=";
  };
  meta = {
    description = "HyDE Theme: Greenify";
    homepage = "https://github.com/mahaveergurjar/Theme-Gallery/tree/Greenify";
    priority = 10;
  };
}
