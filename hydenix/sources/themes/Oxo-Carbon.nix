{ pkgs, mkTheme }:
mkTheme rec {
  name = "Oxo Carbon";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Oxo-Carbon";
    rev = "Oxo-Carbon";
    name = name;
    sha256 = "sha256-w+7Gky7L2crF4F7myhA64fXgjoWulLb/hWBaI6OMwBo=";
  };
  meta = {
    description = "HyDE Theme: Oxo Carbon";
    homepage = "https://github.com/rishav12s/Oxo-Carbon";
    priority = 10;
  };
}
