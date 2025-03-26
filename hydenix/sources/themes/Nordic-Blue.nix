{ pkgs, mkTheme }:
mkTheme rec {
  name = "Nordic Blue";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Nordic-Blue";
    name = name;
    sha256 = "sha256-kf1jFKVgx+7wOBTOH4iJNzQgOTGq8VK7SwWjDZHhjuo=";
  };
  meta = {
    description = "HyDE Theme: Nordic Blue";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Nordic-Blue";
    priority = 100;
  };
}
