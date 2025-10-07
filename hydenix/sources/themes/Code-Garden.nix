{ pkgs, mkTheme }:
mkTheme rec {
  name = "Code Garden";
  src = pkgs.fetchFromGitHub {
    owner = "jacobfranco";
    repo = "Code-Garden";
    rev = "main";
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
