{ config, lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  networking.hostName = "hyprnix";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Ho_Chi_Minh";

  i18n.defaultLocale = "en_US.UTF-8";

  security.pam.services.hyprlock = { };

  users.users.vantm = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    curl
    git
    less
    nerd-fonts._0xproto
  ];

  fonts.packages = [ pkgs.nerd-fonts._0xproto ];

  services.displayManager.ly = {
    enable = true;
    settings.xinitrc = null;
  };

  services.libinput.enable = true;

  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  programs.sway.enable = true;

  system.copySystemConfiguration = true;

  system.stateVersion = "25.11";
}

