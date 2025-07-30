{
  hydenix-inputs,
  ...
}:

hydenix-inputs.hydenix-nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = {
    inherit hydenix-inputs;
  };
  modules = [
    ./configuration.nix
  ];
}
