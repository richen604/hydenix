{ pkgs, mkTheme }:
mkTheme rec {
  name = "Solarized Dark";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Solarized-Dark";
    rev = "06908339fb4e89adddca3a11d7aec5738e5e17a0";
    name = name;
    sha256 = "sha256-naLPzGyGK3jQSILdP5vkG2coEOqkQ4Q/dHUBJlUa2pI=";
  };
  meta = {
    description = "HyDE Theme: Solarized Dark";
    homepage = "https://github.com/rishav12s/Solarized-Dark";
    priority = 10;
  };
}
