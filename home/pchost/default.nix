{ config, pkgs, username, hostname, outputs, ... }:
{
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };

  imports = [
    ../modules/cursor
    ../modules/inputMethod
    ../modules/darkMode
    ../modules/xdg
    ../modules/clipboard

    ../modules/zsh
    ../modules/git

    ../modules/wayland
    #../modules/sway
    ../modules/hypr
    ../modules/waybar

    ../modules/wpaper
    ../modules/tofi

    ../modules/neovim
    ../modules/alacritty

    ../modules/k9s
    ../modules/rider

    ../modules/programs.nix

    ./monitors.nix
  ];
}
