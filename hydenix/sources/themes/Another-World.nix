{ pkgs, mkTheme }:
mkTheme rec {
  name = "Another World";
  src = pkgs.fetchFromGitHub {
    owner = "cyb3rgh0u1";
    repo = "Another-World";
    rev = "main";
    name = name;
    sha256 = "sha256-91g0u+oOBXL6PBV6q0DUA4HX8KMcSS47pLxqadaxb58=";
  };

  arcs = {
    gtk = "Kripton";
    icon = "Vivid-Glassy-Dark-Icons";
    cursor = "Sweet-cursors";
  };

  meta = {
    description = "HyDE Theme: Another World";
    homepage = "https://github.com/cyb3rgh0u1/Another-World";
    priority = 10;
  };
}
