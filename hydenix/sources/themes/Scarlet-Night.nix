{ pkgs, mkTheme }:
mkTheme rec {
  name = "Scarlet Night";
  src = pkgs.fetchFromGitHub {
    owner = "abenezerw";
    repo = "Scarlet-Night";
    rev = "5edc142b5fad20985ee4049ee497479bfe03776a";
    name = name;
    sha256 = "sha256-+RNKfwc8mfgSnNifMcxlHyBTzDvY5DXAJeNKbJsD8AU=";
  };
  meta = {
    description = "HyDE Theme: Scarlet Night";
    homepage = "https://github.com/abenezerw/Scarlet-Night";
  };
}
