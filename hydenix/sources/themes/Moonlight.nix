{ pkgs, mkTheme }:
mkTheme rec {
  name = "Moonlight";
  src = pkgs.fetchFromGitHub {
    owner = "Maroc02";
    repo = "Moonlight";
    rev = "cc389fdcd8ac9903bbb33895717f710c1bf94f34";
    name = name;
    sha256 = "sha256-MEjuTBNt/C6bKt5TR1yYPJ1fsDVvWO4hHTD49Dc9Phk=";
  };
  meta = {
    description = "HyDE Theme: Moonlight";
    homepage = "https://github.com/Maroc02/Moonlight";
    priority = 10;
  };
}
