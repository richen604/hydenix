{ pkgs }:
let
  utils = import ../utils { inherit pkgs; };
in
utils.mkTheme rec {
  name = "Paranoid Sweet";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Paranoid-Sweet";
    rev = "Paranoid-Sweet";
    name = name;
    sha256 = "sha256-0FhznHsg2ov4XYVvhY0y5Uy45s2nWMi8JZMQPBUvpPg=";
  };

  meta = {
    description = "HyDE Theme: Paranoid Sweet";
    homepage = "https://github.com/rishav12s/Paranoid-Sweet";
  };
}
