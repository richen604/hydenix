{ pkgs, lib }:

pkgs.stdenv.mkDerivation {
  name = "hyde-gallery";

  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-gallery";
    rev = "8067df5d450294d3c477f5f40a804e1cafc5336f";
    name = "hyde-gallery";
    sha256 = "";
  };

  installPhase = ''
    mkdir -p $out/share/hyde/hyde-gallery
    cp -r . $out/share/hyde/hyde-gallery
  '';

  # Add meta information
  meta = {
    description = "Gallery of themes for HyDE";
    homepage = "https://github.com/HyDE-Project/hyde-gallery";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
