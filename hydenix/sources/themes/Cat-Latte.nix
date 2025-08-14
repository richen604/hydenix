{ pkgs, mkTheme }:
mkTheme rec {
  name = "Cat Latte";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Cat-Latte";
    name = name;
    rev = "Cat-Latte";
    sha256 = "sha256-giarUq0eQS8qLfnpGIKQ6pw6sqAcaYohnxC305OkPLc=";
  };
  meta = {
    description = "Better Catppuccin-Latte that fixes the inconsistencies of the official theme";
    homepage = "https://github.com/rishav12s/Cat-Latte";
    priority = 10;
  };
}
