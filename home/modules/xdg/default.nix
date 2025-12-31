{ pkgs, ... }:
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  xdg.portal = {
    enable = true;
    config.common.default = [ "*" ];
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-wlr
    ];
  };

  services.gnome-keyring.enable = true;
}
