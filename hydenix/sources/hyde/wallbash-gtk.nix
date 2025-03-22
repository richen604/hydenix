{ pkgs, commit }:
pkgs.stdenv.mkDerivation rec {
  name = "Wallbash-Gtk";
  src = pkgs.fetchzip {
    url = "https://github.com/HyDE-Project/HyDE/raw/${commit}/Source/arcs/Gtk_Wallbash.tar.gz";
    sha256 = "sha256-I5eR639+WO+qEUkCtDbzcJaVABDp6VOK0+ZO4VRAuWs=";
  };
  installPhase = ''
    mkdir -p $out/share/themes/${name}
    cp -r . $out/share/themes/${name}
  '';
}
