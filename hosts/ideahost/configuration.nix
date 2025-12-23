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

  boot.loader.limine = {
    enable = true;
    extraConfig = ''
      term_palette: 1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
      term_palette_bright: 585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
      term_background: 1e1e2e
      term_foreground: cdd6f4
      term_background_bright: 585b70
      term_foreground_bright: cdd6f4
    '';
    style.wallpapers = [];
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  boot.kernelParams = [ "quite" ];

  networking.hostName = "ideahost";

  networking.dhcpcd.wait = "background";
  networking.dhcpcd.extraConfig = "noarp";

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;

  networking.nameservers = [
    "94.140.14.14"
    "94.140.15.15"
  ];

  services.resolved = {
    enable = true;
    domains = [ "~." ];
    fallbackDns = [
      "94.140.14.14"
      "94.140.15.15"
    ];
  };

  time.timeZone = "Asia/Ho_Chi_Minh";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.vantm = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  environment.systemPackages = with pkgs; [
    curl wget git less vim ntfs3g nerd-fonts._0xproto
  ];

  fonts.packages = [ pkgs.nerd-fonts._0xproto ];

  services.displayManager.ly = {
    enable = true;
    settings.xinitrc = null;
  };

  ## AUDIO

  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
  };

  programs.zsh.enable = true;
  programs.sway.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}

