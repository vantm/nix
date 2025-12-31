{ config, pkgs, username, hostname, outputs, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = outputs.stateVersion;

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
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
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

  systemd.user.services.fcitx5-daemon.Service.Environment = [
    "XMODIFIERS=@im=fcitx"
    "GTK_IM_MODULE=fcitx"
    "QT_IM_MODULE=fcitx"
    "QT_QPA_PLATFORMTHEME=qt6ct"
  ];

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
    extraPortals = [ pkgs.xdg-desktop-portal ];
  };

  services.gnome-keyring.enable = true;

  wayland.systemd.target = "sway-session.target";

  imports = [ ./sway.nix ./programs.nix ];
}
