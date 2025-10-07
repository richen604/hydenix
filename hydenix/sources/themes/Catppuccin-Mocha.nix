{ pkgs, mkTheme }:
mkTheme rec {
  name = "Catppuccin Mocha";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Catppuccin-Mocha";
    name = name;
    sha256 = "sha256-GoXRPYUFdrw6P8OeOsSiFDC9FhaEyo1+lvta0FCJoPY=";
  };
  meta = {
    description = "HyDE Theme: Catppuccin Mocha";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Catppuccin-Mocha";
    priority = 100;
  };
}
