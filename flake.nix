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

        dotnet =
          let
            dotnetPkg = (
              with pkgs.dotnetCorePackages;
              combinePackages [ sdk_10_0 sdk_9_0 sdk_8_0 ]
            );
          in
          pkgs.mkShell {
            packages = with pkgs ; [ dotnetPkg ];
            shellHook = ''
              export DOTNET_ROOT="${dotnetPkg}/share/dotnet"
            '';
          };

        nodejs_20 = pkgs.mkShell {
          packages = with pkgs ; [ nodejs_20 ];
        };

        nestjs = pkgs.mkShell {
          packages = with pkgs ; [ nest-cli ];
        };

        vscode = pkgs.mkShell {
          packages = with pkgs ; [
            jre17_minimal
          ];
          shellHook = ''
            export JAVA_HOME="${pkgs.jre17_minimal}"
          '';
        };

        rider = pkgs.mkShell {
          packages = with pkgs ; [
            nodejs_20
            jre17_minimal
          ];
          shellHook = ''
            export JAVA_HOME="${pkgs.jre17_minimal}"
          '';
        };
      };

      # To format all nix files, run
      # > fd -g '**/*.nix' | xargs nix run .#fmt --
      apps.${system}.fmt = {
        type = "app";
        program = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
      };
    };
}
