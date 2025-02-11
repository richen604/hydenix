{ pkgs, commit }:
pkgs.vscode-utils.buildVscodeExtension {
  name = "wallbash";
  vscodeExtPublisher = "prasanthrangan";
  vscodeExtName = "wallbash";
  vscodeExtUniqueId = "prasanthrangan.wallbash";
  version = "1.0.0";

  src = pkgs.fetchurl {
    url = "https://github.com/HyDE-Project/HyDE/raw/${commit}/Source/arcs/Code_Wallbash.vsix";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  nativeBuildInputs = [ pkgs.unzip ];

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src -d .
    runHook postUnpack
  '';
}
