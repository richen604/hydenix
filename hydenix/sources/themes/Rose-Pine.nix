{ pkgs, mkTheme }:
mkTheme rec {
  name = "Rosé Pine";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Rose-Pine";
    name = name;
    sha256 = "sha256-ySrHzOyySxDYMomuatoz1JFfkWnSg8SUSCbe5QkrJwY=";
  };
  meta = {
    description = "HyDE Theme: Rosé Pine";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Rose-Pine";
    priority = 100;
  };
}
