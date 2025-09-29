{ pkgs, mkTheme }:
mkTheme rec {
  name = "One Dark";
  src = pkgs.fetchFromGitHub {
    owner = "RAprogramm";
    repo = "HyDe-Themes";
    rev = "4109ebca756257b63f22b2b74a5597e1650f3434";
    name = name;
    sha256 = "sha256-j4KXbLb7gvVNCrdqMscsIinhBZoBp4oIzEbwws4fstU=";
  };
  meta = {
    description = "HyDE Theme: One Dark";
    homepage = "https://github.com/RAprogramm/HyDe-Themes/tree/One-Dark";
    priority = 10;
  };
}
