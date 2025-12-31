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
    { self, nixpkgs, home-manager } @ inputs:
    let
      inherit (self) outputs;
      system = "x64_86-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      mkHost = hostname: username: inputs: outputs:  {
        nixosConfiguration.${hostname} = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [ 
            ./hosts/${hostname}/configuration.nix
          ];
          specialArgs = {
            inherit system username hostname;
          };
        };
      };
    in
    {
      inherit (mkHost "ideahost" "vantm" inputs outputs)
        nixosConfiguration
      ;
      stateVersion = "25.11";
    };
}
