{ pkgs, mkTheme }:
mkTheme rec {
  name = "Frosted Glass";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "224e1027e451481db526a095242d261d47a68775";
    name = name;
    sha256 = "sha256-6/KxQNjcFkYPSouvaMDF1cRto9wQS1IhQqFRteGDQUA=";
  };
  meta = {
    description = "HyDE Theme: Frosted Glass";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Frosted-Glass";
    priority = 100;
  };
}
