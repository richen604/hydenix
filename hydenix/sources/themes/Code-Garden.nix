{ pkgs, mkTheme }:
mkTheme rec {
  name = "Code Garden";
  src = pkgs.fetchFromGitHub {
    owner = "jacobfranco";
    repo = "Code-Garden";
    rev = "4d3ce14a1a17029a7cfe4b1b44c24575b596af8d";
    name = name;
    sha256 = "sha256-WvuVrgllMhste24dWGKw3I0eBBJMHoOYQCheLofenUE=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Code Garden";
    homepage = "https://github.com/jacobfranco/Code-Garden";
    priority = 100;
  };
}
