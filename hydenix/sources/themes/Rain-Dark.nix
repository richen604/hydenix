{ pkgs, mkTheme }:
mkTheme rec {
  name = "Rain Dark";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Rain-Dark";
    rev = "da26bafb755fcd96d107cc7b60db43e85e3a3876";
    name = name;
    sha256 = "sha256-zv66a/fh3xqOIYVD6OUi4ZEpn3L29J2vvBnPBjeQW7w=";
  };
  meta = {
    description = "HyDE Theme: Rain Dark";
    homepage = "https://github.com/rishav12s/Rain-Dark";
    priority = 10;
  };
}
