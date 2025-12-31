{ pkgs, ... }:
{
  home.packages = [ pkgs.jetbrains.rider ];
  home.file.".ideavimrc".text = builtins.readFile ./.ideavimrc;
}
