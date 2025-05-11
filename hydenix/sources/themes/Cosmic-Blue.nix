{ pkgs, mkTheme }:
mkTheme rec {
  name = "Cosmic Blue";
  src = pkgs.fetchFromGitHub {
    owner = "Maroc02";
    repo = "Cosmic-Blue";
    rev = "main";
    name = name;
    sha256 = "sha256-K0RSnIjG0U8P3omoEVzkMfZMjearYde2nzy2sRWSHUY=";
  };
  meta = {
    description = "HyDE Theme: Cosmic Blue";
    homepage = "https://github.com/Maroc02/Cosmic-Blue";
    priority = 10;
  };
}
