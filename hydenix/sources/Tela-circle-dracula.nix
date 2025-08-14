{
  lib,
  stdenv,
  pkgs,
}:

stdenv.mkDerivation {
  pname = "Tela-dracula-icon-theme";
  version = "1.0.0"; # You may want to update this with a specific version

  src = pkgs.fetchurl {
    url = "https://github.com/HyDE-Project/hyde-themes/raw/refs/heads/Catppuccin-Mocha/Source/Icon_TelaDracula.tar.gz";
    sha256 = "sha256-UgYCOJrtzwLkIuG7v/CJ33dwHXQdFhbdCRuTzp4LUms=";
  };

  nativeBuildInputs = with pkgs; [
    jdupes
  ];

  installPhase = ''
    mkdir -p $out/share/icons
    tar -xf $src -C $out/share/icons
    jdupes --recurse $out/share/icons
  '';

  meta = {
    description = "Tela Dracula icon theme from HyDE Project";
    homepage = "https://github.com/HyDE-Project/hyde-themes";
    license = lib.licenses.gpl3; # You may need to verify the actual license
    platforms = lib.platforms.all;
    maintainers = [ ];
  };
}
