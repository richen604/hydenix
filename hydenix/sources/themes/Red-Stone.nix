{ pkgs, mkTheme }:
mkTheme rec {
  name = "Red Stone";
  src = pkgs.fetchFromGitHub {
    owner = "mahaveergurjar";
    repo = "Theme-Gallery";
    rev = "Red_Stone";
    name = name;
    sha256 = "sha256-cbg7hBjXg0xTRCZqbo1UUQM7zNoQHEQO6it2VkahYqI=";
  };
  meta = {
    description = "HyDE Theme: Red Stone";
    homepage = "https://github.com/mahaveergurjar/Theme-Gallery/tree/Red-Stone";
    priority = 10;
  };
}
