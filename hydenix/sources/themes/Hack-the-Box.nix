{ pkgs, mkTheme }:
mkTheme rec {
  name = "Hack the Box";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-gallery";
    rev = "f8f6070ec27329c52f145a156dd61929781e2048";
    name = name;
    sha256 = "sha256-VMDs9fnXX0v7iGSftA19UXxANY1sRjrK5ipMsfjU7Tg=";
  };
  meta = {
    description = "HyDE Theme: Hack the Box";
    homepage = "https://github.com/HyDE-Project/hyde-gallery/tree/Hack-the-Box";
    priority = 10;
  };
}
