{ pkgs, mkTheme }:
mkTheme rec {
  name = "Green Lush";
  src = pkgs.fetchFromGitHub {
    owner = "abenezerw";
    repo = "Green-Lush";
    rev = "e3b8b6af05e1f8ec6f2a63c86cf2c7717fd1468d";
    name = name;
    sha256 = "sha256-4k3EXKyHkVPrqnZuviHpmSc+kNIVysZTGu0hd/XT+UA=";
  };
  meta = {
    description = "HyDE Theme: Green Lush";
    homepage = "https://github.com/abenezerw/Green-Lush";
    priority = 10;
  };
}
