{ pkgs, mkTheme }:
mkTheme rec {
  name = "Scarlet Night";
  src = pkgs.fetchFromGitHub {
    owner = "abenezerw";
    repo = "Scarlet-Night";
    rev = "main";
    name = name;
    sha256 = "sha256-+RNKfwc8mfgSnNifMcxlHyBTzDvY5DXAJeNKbJsD8AU=";
  };
  meta = {
    description = "HyDE Theme: Scarlet Night";
    homepage = "https://github.com/abenezerw/Scarlet-Night";
    priority = 10;
  };
}
