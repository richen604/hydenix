{ pkgs, mkTheme }:
mkTheme rec {
  name = "Ice Age";
  src = pkgs.fetchFromGitHub {
    owner = "saber-88";
    repo = "Ice-Age";
    rev = "56564067e8bf74416eaaf68e8c6730e4c381c67a";
    name = name;
    sha256 = "sha256-44l7UTHrCvvJL3TO6hk/SV2fxB9MXJtmSM5S56w8xVQ=";
  };
  meta = {
    description = "HyDE Theme: Ice Age";
    homepage = "https://github.com/saber-88/Ice-Age";
    priority = 10;
  };
}
