{ config, lib, pkgs, username, hostname, outputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hosts/${hostname}/hardware-configuration.nix
    ];

  system.stateVersion = outputs.stateVersion;

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
  boot.loader.timeout = 3;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  boot.kernelParams = [ "quite" ];

  time.timeZone = "Asia/Ho_Chi_Minh";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  services.greetd = {
    enable = true;
    settings = {
      terminal.vt = 1;
      initial_session = {
        user = username;
        command = "sway";
      };
      default_session = {
        user = username;
        command = "${pkgs.greetd}/bin/agreety --cmd sway";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    curl wget git less vim ntfs3g nerd-fonts._0xproto
  ];

  fonts.packages = [ pkgs.nerd-fonts._0xproto ];

  security.rtkit.enable = true;

  # Networking

  networking.hostName = hostname;

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

  systemd.network.wait-online.enable = true;

  # Audio

  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
  };

  programs.zsh.enable = true;
  programs.sway.enable = true;

  programs.nix-ld.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  systemd.user.services.docker.wants = [ "sway-session.target" ];
  systemd.user.services.docker.after = [ "sway-session.target" ];
}

