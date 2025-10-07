{ pkgs, mkTheme }:
mkTheme rec {
  name = "Windows 11";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-gallery";
    rev = "a641e958ad3f54375c9e102ba4be449016d8bfce";
    name = name;
    sha256 = "sha256-rAg4iPOD8sRvKX32N9+8DekwvvmizFC9Q2QwWA7mKz0=";
  };
  meta = {
    description = "HyDE Theme: Windows 11";
    homepage = "https://github.com/HyDE-Project/hyde-gallery/tree/Windows-11";
  };
}
