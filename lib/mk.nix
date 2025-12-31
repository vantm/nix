{
  inputs,
  outputs,
  lib,
  stateVersion,
  ...
}:

{
  mkHome =
    {
      username,
      hostname ? "",
      platform ? "x86_64-linux",
    }:
    inputs.home-manager.lib.homeManagerConfiguration {
      # Common home-manager configuration
      modules = [ ../home ];

      # Packages for given platform
      pkgs = inputs.nixpkgs.legacyPackages.${platform};

      extraSpecialArgs = {
        inherit
          stateVersion
          platform
          hostname
          username
          inputs
          outputs
          ;
      };
    };

  mkHost =
    {
      hostname,
      username ? "",
      platform ? "x86_64-linux",
    }:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [ ../hosts/${hostname}/configuration.nix ]
      specialArgs = {
        inherit
          stateVersion
          username
          hostname
          platform
          ;
      };
    };
}
