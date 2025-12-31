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
          modules = [ ./home ];
          extraSpecialArgs = {
            inherit outputs hostname username;
          };
        };
    in
    {
      stateVersion = "25.11";

      # To apply nixos configuration, run:
      # > ./scripts/switch <hostname>
      nixosConfigurations = {
        ideahost = mkHost "ideahost" "vantm";

        vm = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ({ pkgs, ... }: {
              boot.isContainer = false;

              users.users.root.password = "root";
              services.getty.autologinUser = "root";

              system.stateVersion = outputs.stateVersion;

              virtualisation.vmVariant = {
                virtualisation.memorySize = 2048;
                virtualisation.cores = 2;
              };

              imports = [ <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix> ];

              virtualisation.qemu.options = [
                "-device virtio-vga"
              ];
            })
          ];
        };
      };

      # To apply home-manager configuration, run:
      # > ./scripts/home-switch
      homeConfigurations = {
        ideahost = mkHome "ideahost" "vantm";
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = [ home-manager.packages.${system}.home-manager ];
      };

      # To format all nix files, run
      # > fd -g '**/*.nix' | xargs nix run .#fmt --
      apps.${system}.fmt = {
        type = "app";
        program = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
      };
    };
}
