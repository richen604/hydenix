{ pkgs, mkTheme }:
mkTheme rec {
  name = "Hack the Box";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-gallery";
    rev = "36fa09171cd1d14156086542df020369b9f8b8fa";
    name = name;
    sha256 = "sha256-ww7LoUVHlJhYUE2VSguhE7OZblx0hbQp6IaWAJSLcy4=";
  };
  meta = {
    description = "HyDE Theme: Hack the Box";
    homepage = "https://github.com/HyDE-Project/hyde-gallery/tree/Hack-the-Box";
    priority = 10;
  };
}
