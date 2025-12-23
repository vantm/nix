{ config, pkgs, ... }:
{
  home.username = "vantm";
  home.homeDirectory = "/home/vantm";

  home.stateVersion = "25.11";

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    XMODIFIERS = "@im=fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  home.pointerCursor = {
    name = "Bibata-Original-Classic";
    size = 24;
    package = pkgs.bibata-cursors;
  };

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [ pkgs.fcitx5-bamboo ];
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-icon-theme;
    };
  };

  qt.enable = true;

  xdg.portal = {
    enable = true;
    config.common.default = [ "*" ];
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
  };

  services.gnome-keyring.enable = true;

  imports = [ ./sway.nix ./programs.nix ];
}
