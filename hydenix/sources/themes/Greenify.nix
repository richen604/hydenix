{ pkgs, mkTheme }:
mkTheme rec {
  name = "Greenify";
  src = pkgs.fetchFromGitHub {
    owner = "mahaveergurjar";
    repo = "Theme-Gallery";
    name = name;
    rev = "c7d369fb3cdac01572a8b21b077cd59b3379e878";
    sha256 = "sha256-5UhGEVAKCnjQ8pWZ2+zjaheWOM4lZ++5DqoUGXikNls=";
  };
  meta = {
    description = "HyDE Theme: Greenify";
    homepage = "https://github.com/mahaveergurjar/Theme-Gallery/tree/Greenify";
    priority = 10;
  };
}
