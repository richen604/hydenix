{
  hydenix-inputs,
  ...
}:

hydenix-inputs.hydenix-nixpkgs.lib.nixosSystem {
  inherit (hydenix-inputs.lib) system;
  specialArgs = {
    inherit hydenix-inputs;
  };
  modules = [
    ./configuration.nix
  ];
}
