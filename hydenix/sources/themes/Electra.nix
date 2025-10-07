{ pkgs, mkTheme }:
mkTheme rec {
  name = "Electra";
  src = pkgs.fetchFromGitHub {
    owner = "XBEAST1";
    repo = "Electra";
    rev = "master";
    name = name;
    sha256 = "sha256-PG2Vud9BTMuOkT2dHYNl1sDdTFsMLugc5qfWWs/fYFE=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Electra";
    homepage = "https://github.com/XBEAST1/Electra";
    priority = 80;
  };
}
