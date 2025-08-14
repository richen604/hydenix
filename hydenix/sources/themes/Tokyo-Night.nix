{ pkgs, mkTheme }:
mkTheme rec {
  name = "Tokyo Night";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Tokyo-Night";
    name = name;
    sha256 = "sha256-pPeNr8hbJ7wgGkYxFdvHdrBfkZpNRlKgQfhIF7rQKWU=";
  };
  meta = {
    description = "HyDE Theme: Tokyo Night";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Tokyo-Night";
    priority = 100;
  };
}
