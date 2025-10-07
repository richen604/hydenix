{ pkgs, mkTheme }:
mkTheme rec {
  name = "Electra";
  src = pkgs.fetchFromGitHub {
    owner = "XBEAST1";
    repo = "Electra";
    rev = "61cd9718d7c517c35db11b402e9f958537ae32da";
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
