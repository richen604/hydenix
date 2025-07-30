{
  hydenix-inputs,
}:

let
  system = "x86_64-linux";
  pkgs = import hydenix-inputs.hydenix-nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  # Function to create Hyde package with specific source
  mkHyde =
    src:
    import ../../hydenix/sources/hyde.nix {
      inherit pkgs;
      inputs = hydenix-inputs // {
        hyde = src;
      };
    };

  # Current pinned Hyde version
  hyde-pinned = mkHyde hydenix-inputs.hyde;

  # Latest master Hyde version
  hyde-master = mkHyde (
    pkgs.fetchFromGitHub {
      owner = "HyDE-Project";
      repo = "HyDE";
      rev = "master";
      sha256 = "sha256-rYlD979i1XUDZg+okpJZSC4piQKwJiIocfEYjxMyaz8=";
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
