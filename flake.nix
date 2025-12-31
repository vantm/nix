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
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      mkHost = hostname: username:
        nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/${hostname}/configuration.nix ];
          specialArgs = { 
            inherit outputs hostname username;
          };
        };
      mkHome = hostname: username:
        home-manager.lib.homeManagerConfiguration {
         pkgs = import inputs.nixpkgs {
         inherit system;
           config.allowUnfreePredicate = pkg:
             builtins.elem (inputs.nixpkgs.lib.getName pkg) [
               "vscode"
               "spotify"
               "rider"
             ];
          };
          modules = [ ./home/home.nix ];
          extraSpecialArgs = {
            inherit outputs hostname username;
          };
        };
    in
    {
      nixosConfigurations = {
        ideahost = mkHost "ideahost" "vantm";
      };
      homeConfigurations = {
        ideahost = mkHome "ideahost" "vantm";
      };
      devShells.${system}.default = pkgs.mkShell {
        packages = [ home-manager.packages.${system}.home-manager ];
      };
      stateVersion = "25.11";
    };
}
