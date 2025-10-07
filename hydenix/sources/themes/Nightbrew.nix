{ pkgs, mkTheme }:
mkTheme rec {
  name = "Nightbrew";
  src = pkgs.fetchFromGitHub {
    owner = "jackpawlik1";
    repo = "Nightbrew";
    rev = "7cd0355316c1d302cda31076d0a713549007d1bd";
    name = name;
    sha256 = "sha256-yoAU7x8blO2pTQCy64+c8Y4XKdlFF04Wx8aAkX2xMUc=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Nightbrew";
    homepage = "https://github.com/jackpawlik1/Nightbrew";
  };
}
