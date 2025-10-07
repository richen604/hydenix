{ pkgs, mkTheme }:
mkTheme rec {
  name = "DoomBringers";
  src = pkgs.fetchFromGitHub {
    owner = "xaicat";
    repo = "DoomBringers";
    rev = "main";
    name = name;
    sha256 = "sha256-bxV7YSdI1BM63eSV5nkkfvMmqgtWaKo9Xp2JKCpukvM=";
  };
  meta = {
    description = "HyDE Theme: DoomBringers";
    homepage = "https://github.com/xaicat/DoomBringers";
    priority = 10;
  };
}
