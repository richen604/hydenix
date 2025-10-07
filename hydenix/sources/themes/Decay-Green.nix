{ pkgs, mkTheme }:
mkTheme rec {
  name = "Decay Green";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Decay-Green";
    name = name;
    sha256 = "sha256-Vg9WsRPrkpkQMtOT+8rjf7CKiCvTQ12XZYX6hfUU0h0=";
  };
  meta = {
    description = "HyDE Theme: Decay Green";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Decay-Green";
    priority = 100;
  };
}
