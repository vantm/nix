{ pkgs, ... }:
{
  security.rtkit.enable = true;

  programs.sway.enable = true;

  fonts.packages = [ pkgs.nerd-fonts._0xproto ];
}
