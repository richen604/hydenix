{ pkgs, mkTheme }:
mkTheme rec {
  name = "Ever Blushing";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Ever-Blushing";
    rev = "Ever-Blushing";
    name = name;
    sha256 = "sha256-DCRdN9OeT1sEQEQFYN1F4OAEwcgFgPOTx2bJ8TO6Nj8=";
  };
  meta = {
    description = "HyDE Theme: Ever-Blushing";
    homepage = "https://github.com/rishav12s/Ever-Blushing";
    priority = 10;
  };
}
