{ pkgs, mkTheme }:
mkTheme rec {
  name = "Nordic Blue";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "7dd56df71c355ffdc847b43b6bea6c20e00f2726";
    name = name;
    sha256 = "sha256-b1w1EpS0GlAXAEPNSEOYqVtZnoHamqSqlsGSucTzPVg=";
  };
  meta = {
    description = "HyDE Theme: Nordic Blue";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Nordic-Blue";
  };
}
