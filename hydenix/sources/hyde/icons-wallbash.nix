{
  lib,
  stdenv,
  fetchurl,
  commit,
}:

stdenv.mkDerivation {
  pname = "icon-wallbash";
  version = "1.0.0";

  src = fetchurl {
    url = "https://github.com/HyDE-Project/HyDE/raw/${commit}/Source/arcs/Icon_Wallbash.tar.gz";
    sha256 = "sha256-W9xW2YKXtKA1jwawZpAUqbqMLQ62TkUtbdmqAJWSZ8g=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    tar -xzf $src -C $out
  '';

  meta = with lib; {
    description = "Icon resources for Wallbash component of HyDE project";
    homepage = "https://github.com/HyDE-Project/HyDE";
    platforms = platforms.all;
  };
}
