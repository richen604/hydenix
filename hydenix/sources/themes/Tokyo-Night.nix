{ pkgs, mkTheme }:
mkTheme rec {
  name = "Tokyo Night";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Tokyo-Night";
    name = name;
    sha256 = "sha256-ntM6cfHI4BBiFkp1ylqDjZxAqefV4x/rG0A6gqD1jR4=";
  };
  meta = {
    description = "HyDE Theme: Tokyo Night";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Tokyo-Night";
    priority = 100;
  };
}
