{ pkgs, mkTheme }:
mkTheme rec {
  name = "Sci-fi";
  src = pkgs.fetchFromGitHub {
    owner = "KaranRaval123";
    repo = "Sci-fi";
    rev = "52091e9658319a4d0da0bc19c57f55f3c1b539f0";
    name = name;
    sha256 = "sha256-gnAvPuHBfH+PspSxkzOA2jIIHox2Fi+nMSsoZAJHGlw=";
  };
  meta = {
    description = "HyDE Theme: Sci-fi";
    homepage = "https://github.com/KaranRaval123/Sci-fi";
    priority = 20;
  };
}
