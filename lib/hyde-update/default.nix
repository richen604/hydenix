{
  inputs,
}:

let
  system = "x86_64-linux";
  pkgs = import inputs.hydenix-nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  # Function to create Hyde package with specific source
  mkHyde =
    src:
    import ../../hydenix/sources/hyde.nix {
      inherit pkgs;
      inputs = inputs // {
        hyde = src;
      };
    };

  # Current pinned Hyde version
  hyde-pinned = mkHyde inputs.hyde;

  # Latest master Hyde version
  hyde-master = mkHyde (
    pkgs.fetchFromGitHub {
      owner = "HyDE-Project";
      repo = "HyDE";
      rev = "168287f2f10e95a4a9a623c955c7e08147c48472";
      sha256 = "sha256-hT7xLsfqsVwcYS/YscRwVOPqK8ZpubhGdpK58INkdJ0=";
    }
  );
in
pkgs.writeShellApplication {
  name = "hyde-update";
  runtimeInputs = with pkgs; [
    coreutils
    diffutils
  ];
  # Pass the built packages to the script
  text = ''
    export HYDE_PINNED="${hyde-pinned}"
    export HYDE_MASTER="${hyde-master}"
    ${builtins.readFile ./run.sh}
  '';
}
