{ pkgs, mkTheme }:
mkTheme rec {
  name = "Graphite Mono";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "ab5030a3b808b0754e30a2867a2fa217956e66d2";
    name = name;
    sha256 = "sha256-bA07uhuF67ZN6USBsF5fvSFvPe/tiHQzxvV1dFEoXYI=";
  };
  meta = {
    description = "HyDE Theme: Graphite Mono";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Graphite-Mono";
  };
}
