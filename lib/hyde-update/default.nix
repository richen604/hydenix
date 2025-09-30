{
  inputs,
}:

let
  system = "x86_64-linux";
  pkgs = import inputs.nixpkgs {
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
      rev = "f246f2a89b8e862b96042cb2b291b191289c2fde";
      sha256 = "sha256-fXW+yxDQ0iLFX2YuKDpv82lIPbGDgii5kpsWCDp3m4s=";
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
