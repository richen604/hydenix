{ pkgs, mkTheme }:
mkTheme rec {
  name = "Joker";
  src = pkgs.fetchFromGitHub {
    owner = "saber-88";
    repo = "Joker";
    # locking commit
    rev = "b7bae7bd943ca445e9ff53ba6450e63204d94228";
    name = name;
    sha256 = "sha256-XtA1pw8019XX3BZ0+ddSkWEMPni63+5AwNxYpgr4do4=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Joker";
    homepage = "https://github.com/saber-88/Joker";
  };
}
