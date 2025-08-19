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
      hyde = callPackage ./hyde.nix { inherit inputs; };
      # Theme packages from the themes directory
      themes = callPackage ./themes/default.nix { };
      hyq = inputs.hyq.packages.${prev.system}.default;
      hydectl = inputs.hydectl.packages.${prev.system}.default;
      hyde-ipc = inputs.hyde-ipc.packages.${prev.system}.default;
      hyde-config = inputs.hyde-config.packages.${prev.system}.default;
    };
  };
in
packages
