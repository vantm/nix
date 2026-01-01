{ pkgs, ... }:
{
  services.cliphist = {
    enable = true;
    clipboardPackage = pkgs.wl-clipboard;
  };
}
