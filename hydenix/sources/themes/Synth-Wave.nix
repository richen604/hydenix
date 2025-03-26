{ pkgs, mkTheme }:
mkTheme rec {
  name = "Synth Wave";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-themes";
    rev = "61c389a0ba3c0858e000436a359385389cda7f44";
    name = name;
    sha256 = "sha256-2qkR61CaUyHry/clQb7WVMSt4rV+4c4yElRxqSwF73Y=";
  };
  meta = {
    description = "HyDE Theme: Synth Wave";
    homepage = "https://github.com/HyDE-Project/hyde-themes/tree/Synth-Wave";
    priority = 100;
  };
}
