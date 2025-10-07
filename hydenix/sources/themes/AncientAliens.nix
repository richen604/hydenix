{ pkgs, mkTheme }:
mkTheme rec {
  name = "AncientAliens";
  src = pkgs.fetchFromGitHub {
    owner = "dim-ghub";
    repo = "AncientAliens";
    name = name;
    rev = "main";
    sha256 = "sha256-lcrl87sYXNg17oxL1hnGvrcZPpPkCRFllIGWf9/1bZU=";
  };
  meta = {
    description = "HyDE Theme: AncientAliens";
    homepage = "https://github.com/dim-ghub/AncientAliens";
    priority = 100;
  };
}
