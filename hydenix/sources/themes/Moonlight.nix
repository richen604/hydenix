{ pkgs, mkTheme }:
mkTheme rec {
  name = "Moonlight";
  src = pkgs.fetchFromGitHub {
    owner = "Maroc02";
    repo = "Moonlight";
    rev = "main";
    name = name;
    sha256 = "sha256-rqgdiddv3WjMmb7uOfUBjCde+T5oYHT41Zc08RSDK3s=";
  };
  meta = {
    description = "HyDE Theme: Moonlight";
    homepage = "https://github.com/Maroc02/Moonlight";
    priority = 10;
  };
}
