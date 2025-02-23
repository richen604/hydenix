{
  commonArgs,
}:
let
  inherit (commonArgs)
    system
    userConfig
    inputs
    userPkgs
    ;
in
inputs.hydenix-nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {
    inherit userConfig inputs userPkgs;
  };
  modules = [
    {
      nixpkgs.pkgs = commonArgs.pkgs;
    }
    ./configuration.nix
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${userConfig.username} =
        { ... }:
        {
          imports = [
            ./home.nix
            inputs.nix-index-database.hmModules.nix-index
          ] ++ userConfig.homeModules;
        };
      home-manager.extraSpecialArgs = {
        inherit userConfig inputs userPkgs;
      };
    }
  ] ++ userConfig.nixModules;
}
