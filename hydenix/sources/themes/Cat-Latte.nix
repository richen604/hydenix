{ pkgs, mkTheme }:
mkTheme rec {
  name = "Cat Latte";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Cat-Latte";
    name = name;
    rev = "1ee66b25ce7e8251e1af0556a9a486832bbef14c";
    sha256 = "sha256-RQ2M4CUQr9xziYRWHLM1zvA9OGZRc0kvfQwv+n4LX5Q=";
  };
  meta = {
    description = "Better Catppuccin-Latte that fixes the inconsistencies of the official theme";
    homepage = "https://github.com/rishav12s/Cat-Latte";
    priority = 10;
  };
}
