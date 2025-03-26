{ pkgs, mkTheme }:
mkTheme rec {
  name = "Scarlet Night";
  src = pkgs.fetchFromGitHub {
    owner = "abenezerw";
    repo = "Scarlet-Night";
    rev = "1c80ed42231de2afcda28e48793e395e3f0955d2";
    name = name;
    sha256 = "sha256-RtZQpL0ZzjsLOT812JCnhbW6aIya+6I9FO+fCxWIPRY=";
  };
  meta = {
    description = "HyDE Theme: Scarlet Night";
    homepage = "https://github.com/abenezerw/Scarlet-Night";
    priority = 10;
  };
}
