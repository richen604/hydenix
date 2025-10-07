{ pkgs, mkTheme }:
mkTheme rec {
  name = "Breezy Autumn";
  src = pkgs.fetchFromGitHub {
    owner = "Maroc02";
    repo = "Breezy-Autumn";
    # locking commit
    rev = "db980839c1f3daae629a11def5fb479ae3eebf5e";
    name = name;
    sha256 = "sha256-ffEKwNoJDk31JMOC0bYevyW9iJMHv4Xg1e9l5sWnpnE=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Breezy Autumn";
    homepage = "https://github.com/Maroc02/Breezy-Autumn";
  };
}
