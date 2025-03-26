{ pkgs, mkTheme }:
mkTheme rec {
  name = "Green Lush";
  src = pkgs.fetchFromGitHub {
    owner = "abenezerw";
    repo = "Green-Lush";
    rev = "61a21b77a8b285b88f3cc5e1677dae64456dd370";
    name = name;
    sha256 = "sha256-Z0TdPlk5sPIAVZvoZeEbzs61XhTx5p6q9vm3hhhhY0o=";
  };
  meta = {
    description = "HyDE Theme: Green Lush";
    homepage = "https://github.com/abenezerw/Green-Lush";
    priority = 10;
  };
}
