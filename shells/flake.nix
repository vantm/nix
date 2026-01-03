{
  description = "Personal dev shells";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system} = {
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
    };
}
