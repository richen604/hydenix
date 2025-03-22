{
  lib,
  stdenv,
  pkgs,
}:

stdenv.mkDerivation {
  pname = "Bibata-Modern-Ice";
  version = "1.0.0";

  src = pkgs.fetchurl {
    url = "https://github.com/HyDE-Project/HyDE/raw/refs/heads/master/Source/arcs/Cursor_BibataIce.tar.gz";
    sha256 = "sha256-pYvIxOZ3jvcLrv4bDYPc0FPkPLydyWwltFLCZ7aILaQ=";
  };

  nativeBuildInputs = with pkgs; [
    jdupes
  ];

  installPhase = ''
    mkdir -p $out/share/icons/
    tar -xf $src -C $out/share/icons/
    jdupes --recurse $out/share/icons/
  '';

  meta = with lib; {
    description = "Bibata Modern Ice cursor theme";
    homepage = "https://github.com/HyDE-Project/HyDE";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = [ ];
  };
}
