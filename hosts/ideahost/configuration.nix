{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  system.stateVersion = "25.11";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;
  boot.consoleLogLevel = 3;
  boot.kernelParams = [ "quite" ];

  networking.hostName = "ideahost";
  networking.wireless.iwd.enable = true;
  networking.nameservers = [
    "94.140.14.14:5353#adguard-dns.io"
    "94.140.15.15:5353#adguard-dns.io"
  ];

  time.timeZone = "Asia/Ho_Chi_Minh";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.vantm = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    curl wget git less vim ntfs3g nerd-fonts._0xproto
  ];

  fonts.packages = [ pkgs.nerd-fonts._0xproto ];

  services.displayManager.ly = {
    enable = true;
    settings.xinitrc = null;
  };

  services.resolved = {
    enable = true;
    domains = [ "~." ];
    fallbackDns = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
    ];
  };

  programs.zsh.enable = true;
  programs.sway.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}

