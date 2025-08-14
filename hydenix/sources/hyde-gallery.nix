{ pkgs, lib }:

pkgs.stdenv.mkDerivation {
  name = "hyde-gallery";

  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-gallery";
    rev = "9d819748ed54e6b04e25a7909d774d48db8edd58";
    name = "hyde-gallery";
    sha256 = "sha256-tEsTnNgsNBwjHWTTPhyUXqdxcoVmxtwYkmMslc/eMWY=";
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
