{ pkgs, mkTheme }:
mkTheme rec {
  name = "Tundra";
  src = pkgs.fetchFromGitHub {
    owner = "Prof-Shiba";
    repo = "Tundra";
    name = name;
    rev = "70548d07f50e76c59927c989be23b5cc1b2e0a07";
    sha256 = "sha256-bxBXY8YU77w2MCtgOgSU4ujgPwA/MURJUPw1GnIijFM=";
  };
  meta = {
    description = "HyDE Theme: Tundra";
    homepage = "https://github.com/Prof-Shiba/Tundra";
  };
}
