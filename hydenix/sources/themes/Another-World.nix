{ pkgs, mkTheme }:
mkTheme rec {
  name = "Another World";
  src = pkgs.fetchFromGitHub {
    owner = "cyb3rgh0u1";
    repo = "Another-World";
    rev = "82d80baed02216017d5800666cb266ded8dffca3";
    name = name;
    sha256 = "sha256-DLx+8kuW2DrTWFFrbB670iHKYqUfzNUvfQobKjUlVsY=";
  };
  meta = {
    description = "HyDE Theme: Another World";
    homepage = "https://github.com/cyb3rgh0u1/Another-World";
  };
}
