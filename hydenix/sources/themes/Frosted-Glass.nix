{ pkgs, mkTheme }:
mkTheme rec {
  name = "Frosted Glass";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Frosted-Glass";
    name = name;
    sha256 = "sha256-S+4FATRHHwdYgz5pHsV/ycV6kmPAuzYVaTn85zVIt+Q=";
  };

  arcs = {
    gtk = "Frosted-Glass";
    icon = "Tela-circle-blue";
  };

  meta = {
    description = "HyDE Theme: Frosted Glass";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Frosted-Glass";
    priority = 100;
  };
}
