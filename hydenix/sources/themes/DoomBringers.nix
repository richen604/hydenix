{ pkgs, mkTheme }:
mkTheme rec {
  name = "DoomBringers";
  src = pkgs.fetchFromGitHub {
    owner = "xaicat";
    repo = "DoomBringers";
    rev = "f42efdab861c7750fd31ff7e54b0378d363029e7";
    name = name;
    sha256 = "sha256-bxV7YSdI1BM63eSV5nkkfvMmqgtWaKo9Xp2JKCpukvM=";
  };
  meta = {
    description = "HyDE Theme: DoomBringers";
    homepage = "https://github.com/xaicat/DoomBringers";
  };
}
