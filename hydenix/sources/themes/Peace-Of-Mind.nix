{ pkgs, mkTheme }:
mkTheme rec {
  name = "Peace Of Mind";
  src = pkgs.fetchFromGitHub {
    owner = "Maroc02";
    repo = "Peace-Of-Mind";
    rev = "45ee6f24bc7f4cabdc8478e00c44172e907ba9e4";
    name = name;
    sha256 = "sha256-9FpH9PvykUHzJOp3NkWeExoM2taesHmVmruUge5xH3M=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Peace Of Mind";
    homepage = "https://github.com/Maroc02/Peace-Of-Mind";
    priority = 100;
  };
}
