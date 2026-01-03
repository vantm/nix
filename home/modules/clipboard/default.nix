{ pkgs, ... }:
{
  home.packages = [ pkgs.wl-clipboard ];

  services.cliphist = {
    enable = true;
    clipboardPackage = pkgs.wl-clipboard;
  };
}
