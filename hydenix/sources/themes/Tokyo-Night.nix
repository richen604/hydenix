{ pkgs, mkTheme }:
mkTheme rec {
  name = "Tokyo Night";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "da8c38b7a6927eb585203e28fb8e403203578fe5";
    name = name;
    sha256 = "sha256-YL91+Q7CIGT+Ams9FOdw343OgQ19NWz6GJZEG37Gg9A=";
  };
  meta = {
    description = "HyDE Theme: Tokyo Night";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Tokyo-Night";
    priority = 100;
  };
}
