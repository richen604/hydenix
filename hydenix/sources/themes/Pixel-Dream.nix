{ pkgs, mkTheme }:
mkTheme rec {
  name = "Pixel Dream";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Pixel-Dream";
    rev = "c7765210fe3610742ccb955278f2f3a2ebe3f0d9";
    name = name;
    sha256 = "sha256-vPtWjTWHttUPJBtxcJY9jiBrP6jH/r0IIwGmmoINQyw=";
  };
  meta = {
    description = "Pixel Art inspired theme";
    homepage = "https://github.com/rishav12s/Pixel-Dream";
    priority = 10;
  };
}
