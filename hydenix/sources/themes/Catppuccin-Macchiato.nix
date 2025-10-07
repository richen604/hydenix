{ pkgs, mkTheme }:
mkTheme rec {
  name = "Catppuccin-Macchiato";
  src = pkgs.fetchFromGitHub {
    owner = "deepu105";
    repo = "hyde-theme-catppuccin-macchiato";
    # locking commit
    rev = "7f1f33e554a342afcc9723d9b87123aa964cf994";
    name = name;
    sha256 = "sha256-W5xjs+E//G2uhwzjq2tiWUMNdff6xmWUvH59tUoKjA0=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Catppuccin-Macchiato";
    homepage = "https://github.com/deepu105/hyde-theme-catppuccin-macchiato";
  };
}
