{ pkgs, mkTheme }:
mkTheme rec {
  name = "DoomBringers";
  src = pkgs.fetchFromGitHub {
    owner = "xaicat";
    repo = "DoomBringers";
    rev = "main";
    name = name;
    sha256 = "sha256-bFho7wqsjqAeybSJKGoka9ritWEtoNIvDQV2N2ml7b8=";
  };
  meta = {
    description = "HyDE Theme: DoomBringers";
    homepage = "https://github.com/xaicat/DoomBringers";
    priority = 10;
  };
}
