{ pkgs, mkTheme }:
mkTheme rec {
  name = "Rain Dark";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Rain-Dark";
    rev = "385d92ed53bc0190f7f8712eb541e6a703f6961f";
    name = name;
    sha256 = "sha256-1EXbRmCWrcY0NKD9iL+xGmm7ddqLFf4K7ibVSBm2Tuc=";
  };
  meta = {
    description = "HyDE Theme: Rain Dark";
    homepage = "https://github.com/rishav12s/Rain-Dark";
    priority = 10;
  };
}
