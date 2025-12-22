{ config, pkgs, ... }@inputs:
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
  };

  home.pointerCursor = {
    name = "Bibata-Original-Classic";
    size = 20;
    package = pkgs.bibata-cursors;
  };

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = [ pkgs.fcitx5-bamboo ];
    };
  };

  xdg.userDirs = {
    enable = true;
  createDirectories = true;
  };

  imports = [ ./sway.nix ./programs.nix ];
}
