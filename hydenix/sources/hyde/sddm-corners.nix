{
  pkgs,
  commit,
}:
pkgs.stdenv.mkDerivation {
  pname = "sddm-corners-theme";
  name = "Corners";
  version = "1.0.0";

  src = pkgs.fetchzip {
    url = "https://github.com/HyDE-Project/HyDE/raw/${commit}/Source/arcs/Sddm_Corners.tar.gz";
    hash = "sha256-5f3M4tLkSnFU69C+wSH3y4ssqFconQu47A+7XP7ZbH4=";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes/Corners
    cp -r * $out/share/sddm/themes/Corners
  '';

  meta = with pkgs.lib; {
    description = "Corners theme for SDDM";
    homepage = "https://github.com/HyDE-Project/HyDE";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
