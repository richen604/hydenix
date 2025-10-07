{ pkgs, mkTheme }:
mkTheme rec {
  name = "Eternal Arctic";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Eternal-Arctic";
    rev = "bc372b1dc266cca591971c9b4e27a4c4b9108635";
    name = name;
    sha256 = "sha256-Mj/ABDd5o+LCfryNocGju5JUO/hB1v7yxkY2bHe1j3w=";
  };
  meta = {
    description = "HyDE Theme: Eternal-Arctic";
    homepage = "https://github.com/rishav12s/Eternal-Arctic";
    priority = 10;
  };
}
