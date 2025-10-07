{ pkgs, mkTheme }:
mkTheme rec {
  name = "Ever Blushing";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Ever-Blushing";
    rev = "3b90aea08a37ea052296e918e24be0be3400d1be";
    name = name;
    sha256 = "sha256-DCRdN9OeT1sEQEQFYN1F4OAEwcgFgPOTx2bJ8TO6Nj8=";
  };
  meta = {
    description = "HyDE Theme: Ever-Blushing";
    homepage = "https://github.com/rishav12s/Ever-Blushing";
  };
}
