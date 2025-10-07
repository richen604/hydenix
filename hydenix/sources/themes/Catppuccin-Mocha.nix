{ pkgs, mkTheme }:
mkTheme rec {
  name = "Catppuccin Mocha";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "415d22a6bb6348a6d09c11307be54c592fb15138";
    name = name;
    sha256 = "sha256-GoXRPYUFdrw6P8OeOsSiFDC9FhaEyo1+lvta0FCJoPY=";
  };
  meta = {
    description = "HyDE Theme: Catppuccin Mocha";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Catppuccin-Mocha";
  };
}
