{ nixpkgs, home-manager, system, outputs, ... } @inputs:
{
  mkHost = hostname: username: nixpkgs.lib.nixosSystem {
    modules = [
      ({ outputs, ... }: { system.stateVersion = outputs.stateVersion; })
      ../hosts/${hostname}/configuration.nix
    ];
    specialArgs = {
      inherit outputs hostname username;
    };
  };

  mkHome = hostname: username: home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfreePredicate = pkg:
        builtins.elem (inputs.nixpkgs.lib.getName pkg) [
          "vscode"
          "spotify"
          "rider"
        ];
    };
    modules = [
      ({ pkgs, outputs, ... }: {
        nix = {
          package = pkgs.nix;
          settings.experimental-features = [ "nix-command" "flakes" ];
        };

        home.stateVersion = outputs.stateVersion;

        home.username = username;
        home.homeDirectory = "/home/${username}";
      })
      ../home/${hostname}
    ];
    extraSpecialArgs = { inherit outputs hostname username; };
  };

  mkVM = hostname: nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ../hosts/vms/${hostname}.nix
    ];
  };
}
