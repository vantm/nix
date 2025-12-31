{ config, pkgs, username, hostname, outputs, ... }:
{
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = outputs.stateVersion;

  home.sessionVariables = {
    EDITOR = "nvim";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  xdg.portal = {
    enable = true;
    config.common.default = [ "*" ];
    extraPortals = [ pkgs.xdg-desktop-portal ];
  };

  services.gnome-keyring.enable = true;

  wayland.systemd.target = "sway-session.target";

  imports = [
    ./modules/cursor
    ./modules/inputMethod
    ./modules/darkMode

    ./modules/zsh

    ./modules/sway
    ./modules/sway/waybar

    ./modules/neovim
    ./modules/alacritty

    ./modules/rider

    ./modules/programs.nix
  ];
}
