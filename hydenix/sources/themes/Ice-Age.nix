{ pkgs, mkTheme }:
mkTheme rec {
  name = "Ice Age";
  src = pkgs.fetchFromGitHub {
    owner = "saber-88";
    repo = "Ice-Age";
    rev = "main";
    name = name;
    sha256 = "sha256-+U5J+NvCYm9t77vfhdAcWR2ZWh499weSaDQ1ZDPFa3c=";
  };
  meta = {
    description = "HyDE Theme: Ice Age";
    homepage = "https://github.com/saber-88/Ice-Age";
    priority = 10;
  };
}
