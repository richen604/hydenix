{ pkgs, mkTheme }:
mkTheme rec {
  name = "Monokai";
  src = pkgs.fetchFromGitHub {
    owner = "mahaveergurjar";
    repo = "Theme-Gallery";
    rev = "Monokai";
    name = name;
    sha256 = "sha256-bwjFzGVemYCU9zOT7v5gVvnrzsxZ09YlYt87P73nA3I=";
  };
  meta = {
    description = "HyDE Theme: Monokai";
    homepage = "https://github.com/mahaveergurjar/Theme-Gallery/tree/Monokai";
    priority = 10;
  };
}
