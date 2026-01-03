{ pkgs, username, ... }:
{
  security.rtkit.enable = true;

  fonts.packages = [ pkgs.nerd-fonts._0xproto ];

  programs.hyprland.enable = true;

  services.displayManager.ly.enable = true;
}
