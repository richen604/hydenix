{ pkgs, mkTheme }:
mkTheme rec {
  name = "Obsidian-Purple";
  src = pkgs.fetchFromGitHub {
    owner = "amit-0i";
    repo = "Obsidian-Purple";
    rev = "main";
    name = name;
    sha256 = "sha256-wmply5k/FP1QKobCp+ZeaCzdHIlURAxdur3xXAF7qD0=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Obsidian-Purple";
    homepage = "https://github.com/amit-0i/Obsidian-Purple";
    priority = 90;
  };
}
