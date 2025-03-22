{
  pkgs,
  commit,
}:
pkgs.stdenv.mkDerivation {
  pname = "grub-retroboot-theme";
  version = "1.0.0";

  src = pkgs.fetchzip {
    url = "https://github.com/HyDE-Project/HyDE/raw/${commit}/Source/arcs/Grub_Retroboot.tar.gz";
    hash = "sha256-85NTz6588zfHOvZPg69kF5/8f00pNmkpZloJSg6pEQk="; # Replace with actual hash
  };

  installPhase = ''
    mkdir -p $out/share/grub/themes/Retroboot
    cp -r * $out/share/grub/themes/Retroboot
  '';

  meta = with pkgs.lib; {
    description = "Retroboot theme for GRUB";
    homepage = "https://github.com/HyDE-Project/HyDE";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
