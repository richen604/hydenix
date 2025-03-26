{ pkgs, mkTheme }:
mkTheme rec {
  name = "Eternal Arctic";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Eternal-Arctic";
    rev = "Eternal-Arctic";
    name = name;
    sha256 = "sha256-Mj/ABDd5o+LCfryNocGju5JUO/hB1v7yxkY2bHe1j3w=";
  };
  meta = {
    description = "HyDE Theme: Eternal-Arctic";
    homepage = "https://github.com/rishav12s/Eternal-Arctic";
    priority = 10;
  };
}
