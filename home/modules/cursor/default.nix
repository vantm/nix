{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.bibata-cursors ];

    pointerCursor = {
      name = "Bibata-Modern-Ice";
      size = 24;
      package = pkgs.bibata-cursors;
    };
  };
}
