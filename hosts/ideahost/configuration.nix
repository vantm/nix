{ config, lib, pkgs, username, hostname, outputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../modules/boot.nix
      ../modules/user.nix

      ../modules/bluetooth.nix
      ../modules/networking.nix
      ../modules/audio.nix
      ../modules/desktopEnvironment.nix

      ../modules/docker.nix
    ];

  system.stateVersion = outputs.stateVersion;

  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    curl
    wget
    git
    less
    vim
    ntfs3g
  ];

  programs.nix-ld.enable = true;

  services.upower.enable = true;
}

