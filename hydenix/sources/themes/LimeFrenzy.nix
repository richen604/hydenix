{ pkgs, mkTheme }:
mkTheme rec {
  name = "LimeFrenzy";
  src = pkgs.fetchFromGitHub {
    owner = "xaicat";
    repo = "LimeFrenzy";
    name = name;
    rev = "main";
    sha256 = "sha256-mQzSm7XtU1swm77uf0h0rOMqa1hc3uLmiLXdn15dz08=";
  };
  meta = {
    description = "HyDE Theme: LimeFrenzy";
    homepage = "https://github.com/xaicat/LimeFrenzy";
    priority = 100;
  };
}
