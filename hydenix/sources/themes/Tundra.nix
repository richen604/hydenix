{ pkgs, mkTheme }:
mkTheme rec {
  name = "Tundra";
  src = pkgs.fetchFromGitHub {
    owner = "Prof-Shiba";
    repo = "Tundra";
    name = name;
    rev = "main";
    sha256 = "sha256-bxBXY8YU77w2MCtgOgSU4ujgPwA/MURJUPw1GnIijFM=";
  };
  meta = {
    description = "HyDE Theme: Tundra";
    homepage = "https://github.com/Prof-Shiba/Tundra";
    priority = 100;
  };
}
