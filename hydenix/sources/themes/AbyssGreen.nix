{ pkgs, mkTheme }:
mkTheme rec {
  name = "AbyssGreen";
  src = pkgs.fetchFromGitHub {
    owner = "Itz-Abhishek-Tiwari";
    repo = "AbyssGreen";
    name = name;
    rev = "f7e4655f4923a3a4e556b3dab688a5fabadf7675";
    sha256 = "sha256-cosU+0wJSaQspcjYEZA5dMoZARz+8vQM+49Vyf2JvA8=";
  };
  meta = {
    description = "HyDE Theme: AbyssGreen";
    homepage = "https://github.com/Itz-Abhishek-Tiwari/AbyssGreen";
    priority = 10;
  };
}
