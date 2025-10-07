{ pkgs, mkTheme }:
mkTheme rec {
  name = "Rosé Pine";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "4bf9d2cd07cd8f68d62f2b7af28d5f064c66409b";
    name = name;
    sha256 = "sha256-ySrHzOyySxDYMomuatoz1JFfkWnSg8SUSCbe5QkrJwY=";
  };
  meta = {
    description = "HyDE Theme: Rosé Pine";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Rose-Pine";
  };
}
