{ pkgs, mkTheme }:
mkTheme rec {
  name = "Synth Wave";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Synth-Wave";
    name = name;
    sha256 = "sha256-/r9vPTzGrZOx1EhtfxPZFIax08O9EY1PyB3l5XKKtXo=";
  };
  meta = {
    description = "HyDE Theme: Synth Wave";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Synth-Wave";
    priority = 100;
  };
}
