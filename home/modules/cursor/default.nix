{ pkgs, ... }:
{
  home = {
    pointerCursor = {
      name = "Bibata-Modern-Ice";
      size = 20;
      package = pkgs.bibata-cursors;
    };
  };
}
