{ pkgs, mkTheme }:
mkTheme rec {
  name = "Crimson Blade";
  src = pkgs.fetchFromGitHub {
    owner = "cyb3rgh0u1";
    repo = "Crimson-Blade";
    rev = "9603993976e4159e7f858abcf618835d39a1e757";
    name = name;
    sha256 = "sha256-ooQJN3XcE7ZyC2JIlLCC6jraQC9pnwjRSila0Z19G3I=";
  };
  meta = {
    description = "HyDE Theme: A striking fusion of sharp elegance, cutting through the darkness with bold hues.";
    homepage = "https://github.com/cyb3rgh0u1/Crimson-Blade";
  };
}
