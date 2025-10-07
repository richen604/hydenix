{ pkgs, mkTheme }:
mkTheme rec {
  name = "Mac OS";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-gallery";
    rev = "2ce4d3eae646b96133df919c87dc052152033a1d";
    name = name;
    sha256 = "sha256-QmM3JaSLCQn9eqKqSNL13b2DrsxIGiCztbxobsHbbq0=";
  };
  meta = {
    description = "HyDE Theme: Mac OS";
    homepage = "https://github.com/HyDE-Project/hyde-gallery/tree/Mac-Os";
    priority = 10;
  };
}
