{ pkgs, mkTheme }:
mkTheme rec {
  name = "Timeless Dream";
  src = pkgs.fetchFromGitHub {
    owner = "Maroc02";
    repo = "Timeless-Dream";
    # locking commit
    rev = "8a10d655dd42ea175e2196b60c57c21d53f96fbd";
    name = name;
    sha256 = "sha256-QZnGiMjuL+rgDm0puTwIexeaL/x6lf6SsZ8/dLWvTf4=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Timeless Dream";
    homepage = "https://github.com/Maroc02/Timeless-Dream";
  };
}
