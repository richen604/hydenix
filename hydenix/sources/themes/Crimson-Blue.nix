{ pkgs, mkTheme }:
mkTheme rec {
  name = "Crimson-Blue";
  src = pkgs.fetchFromGitHub {
    owner = "amit-0i";
    repo = "Crimson-Blue";
    rev = "main";
    name = name;
    sha256 = "sha256-5fxX6qxG9JHg+cJarybgc0SRrk1AkDTqMXnt+5P3Xpk=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Crimson-Blue";
    homepage = "https://github.com/amit-0i/Crimson-Blue";
    priority = 100;
  };
}
