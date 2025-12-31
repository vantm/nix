{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
    }@inputs:
    let
      inherit (self) outputs;
      mkHost = hostname: username:
        nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/${hostname}/configuration.nix ];
          specialArgs = { 
            inherit outputs hostname username;
          };
        };
    in
    {
      nixosConfigurations = {
        ideahost = mkHost "ideahost" "vantm";
      };
      stateVersion = "25.11";
    };
}
