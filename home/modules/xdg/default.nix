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
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  services.gnome-keyring.enable = true;
}
