{ pkgs, mkTheme }:
mkTheme rec {
  name = "Synth Wave";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "e42e1a10da90f74afda663af122fff996e6585b9";
    name = name;
    sha256 = "sha256-/r9vPTzGrZOx1EhtfxPZFIax08O9EY1PyB3l5XKKtXo=";
  };
  meta = {
    description = "HyDE Theme: Synth Wave";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Synth-Wave";
  };
}
