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
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
  };

  imports = [
    ./modules/cursor
    ./modules/inputMethod
    ./modules/darkMode
    ./modules/xdg
    ./modules/clipboard

    ./modules/zsh
    ./modules/git

    ./modules/sway
    ./modules/sway/waybar

    ./modules/wpaper
    ./modules/tofi

    ./modules/neovim
    ./modules/alacritty

    ./modules/k9s
    ./modules/rider

    ./modules/programs.nix
  ];
}
