{ pkgs, mkTheme }:
mkTheme rec {
  name = "Moonlight";
  src = pkgs.fetchFromGitHub {
    owner = "Maroc02";
    repo = "Moonlight";
    rev = "main";
    name = name;
    sha256 = "sha256-1ZzLxHREUJqm/ckcsmc/95ka4PyoCRR9FF+xoH+egro=";
  };
  meta = {
    description = "HyDE Theme: Moonlight";
    homepage = "https://github.com/Maroc02/Moonlight";
    priority = 10;
  };
}
