{ pkgs, mkTheme }:
mkTheme rec {
  name = "Ice Age";
  src = pkgs.fetchFromGitHub {
    owner = "saber-88";
    repo = "Ice-Age";
    rev = "2691711e8966ce032464be40d22bc1b2a053b9e7";
    name = name;
    sha256 = "sha256-IWevprHXKgGh/h/zBUgDu+hSFkEp4VOwbt6qrWgpsuQ=";
  };
  meta = {
    description = "HyDE Theme: Ice Age";
    homepage = "https://github.com/saber-88/Ice-Age";
  };
}
