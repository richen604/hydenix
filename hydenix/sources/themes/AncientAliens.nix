{ pkgs, mkTheme }:
mkTheme rec {
  name = "AncientAliens";
  src = pkgs.fetchFromGitHub {
    owner = "dim-ghub";
    repo = "AncientAliens";
    name = name;
    rev = "822c5126ef727e75570e174e9f54894f203587ee";
    sha256 = "sha256-lcrl87sYXNg17oxL1hnGvrcZPpPkCRFllIGWf9/1bZU=";
  };
  meta = {
    description = "HyDE Theme: AncientAliens";
    homepage = "https://github.com/dim-ghub/AncientAliens";
  };
}
