{
  description = "My Personal NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    ,
    }:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      libx = import ./lib { inherit system nixpkgs home-manager outputs; };
    in
    {
      stateVersion = "25.11";

      nixosConfigurations = {
        ideahost = libx.mkHost "ideahost" "vantm";
        pchost = libx.mkHost "pchost" "vantm";
        vm = libx.mkVM "nixvm";
      };

      homeConfigurations = {
        ideahost = libx.mkHome "ideahost" "vantm";
        pchost = libx.mkHome "pchost" "vantm";
      };

      devShells.${system} = {
        default = pkgs.mkShell {
          packages = [ home-manager.packages.${system}.home-manager ];
        };
      };

      apps.${system}.fmt = {
        type = "app";
        program = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
      };
    };
}
