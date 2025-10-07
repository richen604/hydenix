{ pkgs, mkTheme }:
mkTheme rec {
  name = "Dracula";
  src = pkgs.fetchFromGitHub {
    owner = "RAprogramm";
    repo = "HyDe-Themes";
    rev = "97209d2e3ad2e0c162ccb585f8cefa8c83899515";
    name = name;
    sha256 = "sha256-0mfuP8jhPtQM4VCGXKhNStse0HePvT0eew4BNh7sOsE=";
  };
  meta = {
    description = "HyDE Theme: Dracula";
    homepage = "https://github.com/RAprogramm/HyDe-Themes/tree/Dracula";
    priority = 10;
  };
}
