{ pkgs, mkTheme }:
mkTheme rec {
  name = "Cosmic Blue";
  src = pkgs.fetchFromGitHub {
    owner = "Maroc02";
    repo = "Cosmic-Blue";
    rev = "main";
    name = name;
    sha256 = "sha256-TKJGuyWyd6R2GdKTRBnrfTGfH9iSVlwr83xZsfvmgPE=";
  };
  meta = {
    description = "HyDE Theme: Cosmic Blue";
    homepage = "https://github.com/Maroc02/Cosmic-Blue";
    priority = 10;
  };
}
