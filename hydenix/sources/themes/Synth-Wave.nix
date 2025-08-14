{ pkgs, mkTheme }:
mkTheme rec {
  name = "Synth Wave";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "Synth-Wave";
    name = name;
    sha256 = "sha256-BV5+A/CnaCX8t9oHt3Q0nxWGJvRUYWQ3IpBK3NlJbj0=";
  };
  meta = {
    description = "HyDE Theme: Synth Wave";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Synth-Wave";
    priority = 100;
  };
}
