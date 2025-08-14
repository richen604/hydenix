{ pkgs, mkTheme }:
mkTheme rec {
  name = "Mac OS";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-gallery";
    rev = "Mac-Os";
    name = name;
    sha256 = "sha256-QmM3JaSLCQn9eqKqSNL13b2DrsxIGiCztbxobsHbbq0=";
  };
  meta = {
    description = "HyDE Theme: Mac OS";
    homepage = "https://github.com/HyDE-Project/hyde-gallery/tree/Mac-Os";
    priority = 10;
  };
}
