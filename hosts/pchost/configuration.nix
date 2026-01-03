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

  boot.loader.limine.extraEntries = ''
    /Windows
      protocol: efi
      path: uuid(f62cf2e4-7a97-4f75-9f7b-240d78adbaa3):/EFI/Microsoft/Boot/bootmgfw.efi
  '';

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

  security.rtkit.enable = true;

  programs.nix-ld.enable = true;
}

