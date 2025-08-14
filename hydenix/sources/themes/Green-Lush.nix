{ pkgs, mkTheme }:
mkTheme rec {
  name = "Green Lush";
  src = pkgs.fetchFromGitHub {
    owner = "abenezerw";
    repo = "Green-Lush";
    rev = "main";
    name = name;
    sha256 = "sha256-4k3EXKyHkVPrqnZuviHpmSc+kNIVysZTGu0hd/XT+UA=";
  };
  meta = {
    description = "HyDE Theme: Green Lush";
    homepage = "https://github.com/abenezerw/Green-Lush";
    priority = 10;
  };
}
