{ pkgs, mkTheme }:
mkTheme rec {
  name = "Moonlight";
  src = pkgs.fetchFromGitHub {
    owner = "Maroc02";
    repo = "Moonlight";
    rev = "main";
    name = name;
    sha256 = "sha256-e3qgwSzmKQnhzEsvdFmOlI8lv55XddTsNIEf6Aig5uM=";
  };
  meta = {
    description = "HyDE Theme: Moonlight";
    homepage = "https://github.com/Maroc02/Moonlight";
    priority = 10;
  };
}
