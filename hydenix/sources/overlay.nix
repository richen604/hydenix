inputs: final: prev:
let
  # Helper function to import a package
  callPackage = prev.lib.callPackageWith (prev // packages // inputs);

  # Define all packages
  packages = {
    # Hyde core packages
    hyde-gallery = callPackage ./hyde-gallery.nix { };
    # Additional packages
    pokego = callPackage ./pokego.nix { };
    python-pyamdgpuinfo = callPackage ./python-pyamdgpuinfo.nix { };
    Tela-circle-dracula = callPackage ./Tela-circle-dracula.nix { };
    Bibata-Modern-Ice = callPackage ./Bibata-Modern-Ice.nix { };
    hydenix = {
      hyde = callPackage ./hyde.nix { };
      # Theme packages from the themes directory
      themes = callPackage ./themes/default.nix { };
    };
  };
in
packages
