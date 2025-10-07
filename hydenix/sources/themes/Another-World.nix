{ pkgs, mkTheme }:
mkTheme rec {
  name = "Another World";
  src = pkgs.fetchFromGitHub {
    owner = "cyb3rgh0u1";
    repo = "Another-World";
    rev = "main";
    name = name;
    sha256 = "sha256-DLx+8kuW2DrTWFFrbB670iHKYqUfzNUvfQobKjUlVsY=";
  };
  meta = {
    description = "HyDE Theme: Another World";
    homepage = "https://github.com/cyb3rgh0u1/Another-World";
    priority = 10;
  };
}
