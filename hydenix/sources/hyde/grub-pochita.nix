{
  pkgs,
  commit,
}:
pkgs.stdenv.mkDerivation {
  pname = "grub-pochita-theme";
  version = "1.0.0";

  src = pkgs.fetchzip {
    url = "https://github.com/HyDE-Project/HyDE/raw/${commit}/Source/arcs/Grub_Pochita.tar.gz";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Replace with actual hash
  };

  installPhase = ''
    mkdir -p $out/share/grub/themes/Pochita
    cp -r * $out/share/grub/themes/Pochita
  '';

  meta = with pkgs.lib; {
    description = "Pochita theme for GRUB";
    homepage = "https://github.com/HyDE-Project/HyDE";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
