{ pkgs, commit }:
pkgs.stdenv.mkDerivation {
  name = "hyde-firefox";

  srcs = [
    (pkgs.fetchzip {
      url = "https://github.com/HyDE-Project/HyDE/raw/${commit}/Source/arcs/Firefox_Extensions.tar.gz";
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    })
    (pkgs.fetchzip {
      url = "https://github.com/HyDE-Project/HyDE/raw/${commit}/Source/arcs/Firefox_UserConfig.tar.gz";
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    })
  ];

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/extensions $out/userconfig
    tar xf Firefox_Extensions.tar.gz -C $out/extensions/
    tar xf Firefox_UserConfig.tar.gz -C $out/userconfig/
  '';
}
