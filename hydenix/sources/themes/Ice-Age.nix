{ pkgs, mkTheme }:
mkTheme rec {
  name = "Ice Age";
  src = pkgs.fetchFromGitHub {
    owner = "saber-88";
    repo = "Ice-Age";
    rev = "main";
    name = name;
    sha256 = "sha256-IWevprHXKgGh/h/zBUgDu+hSFkEp4VOwbt6qrWgpsuQ=";
  };
  meta = {
    description = "HyDE Theme: Ice Age";
    homepage = "https://github.com/saber-88/Ice-Age";
    priority = 15;
  };
}
