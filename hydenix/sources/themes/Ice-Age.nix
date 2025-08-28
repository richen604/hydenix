{ pkgs, mkTheme }:
mkTheme rec {
  name = "Ice Age";
  src = pkgs.fetchFromGitHub {
    owner = "saber-88";
    repo = "Ice-Age";
    rev = "main";
    name = name;
    sha256 = "sha256-hS3PwjzRe7JUaB5eQ6AAS0OUg6fajictQrNdXkpVynw=";
  };
  meta = {
    description = "HyDE Theme: Ice Age";
    homepage = "https://github.com/saber-88/Ice-Age";
    priority = 15;
  };
}
