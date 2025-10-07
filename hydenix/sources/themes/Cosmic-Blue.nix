{ pkgs, mkTheme }:
mkTheme rec {
  name = "Cosmic Blue";
  src = pkgs.fetchFromGitHub {
    owner = "Maroc02";
    repo = "Cosmic-Blue";
    rev = "f5e0e85d333f8ae93caa262f46303efe4c35c5a8";
    name = name;
    sha256 = "sha256-ed9QxS4onniN+kABewK9kBRu9xFMvHU6em+QcP2GrFM=";
  };
  meta = {
    description = "HyDE Theme: Cosmic Blue";
    homepage = "https://github.com/Maroc02/Cosmic-Blue";
  };
}
