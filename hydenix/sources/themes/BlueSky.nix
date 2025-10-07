{ pkgs, mkTheme }:
mkTheme rec {
  name = "BlueSky";
  src = pkgs.fetchFromGitHub {
    owner = "richen604";
    repo = "BlueSky";
    rev = "89bc1e372eb53ece7e785f2fd75341e6d25dd1c9";
    name = name;
    sha256 = "sha256-MiSgGgbJE3kmFd2FtE88fqrrxB1RWZJYPDfn97BoDpw=";
  };
  meta = {
    description = "HyDE Theme: BlueSky";
    homepage = "https://github.com/richen604/BlueSky";
  };
}
