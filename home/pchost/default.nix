{ config, pkgs, username, hostname, outputs, ... }:
{
  imports = [
    ../modules/cursor
    ../modules/inputMethod
    ../modules/darkMode
    ../modules/xdg
    ../modules/clipboard

    ../modules/zsh
    ../modules/git

    ../modules/wayland
    ../modules/sway
    ../modules/sway/waybar

    ../modules/wpaper
    ../modules/tofi

    ../modules/neovim
    ../modules/alacritty

    ../modules/k9s
    ../modules/rider

    ../modules/programs.nix
  ];
}
