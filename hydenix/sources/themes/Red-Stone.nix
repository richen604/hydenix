{ pkgs, mkTheme }:
mkTheme rec {
  name = "Red Stone";
  src = pkgs.fetchFromGitHub {
    owner = "mahaveergurjar";
    repo = "Theme-Gallery";
    rev = "44c499a0a7f0018b06e89b6f41e335566aabf10d";
    name = name;
    sha256 = "sha256-cbg7hBjXg0xTRCZqbo1UUQM7zNoQHEQO6it2VkahYqI=";
  };
  meta = {
    description = "HyDE Theme: Red Stone";
    homepage = "https://github.com/mahaveergurjar/Theme-Gallery/tree/Red-Stone";
  };
}
