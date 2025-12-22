{ pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    config = {
      fonts = {
        names = [ "0xProto Nerd Font" ];
        size = 10.0;
      };
      modifier = "Mod4";
      terminal = "alacritty";
    };
    config.bars = [];
  };

  services.swayidle.enable = true;

  services.cliphist = {
    enable = true;
    systemdTargets = [ "sway-session.target" ];
    clipboardPackage = pkgs.wl-clipboard;
  };

  services.swaync.enable = true;
  services.swayosd.enable = true;

  programs.swaylock.enable = true;

  programs.waybar = {
    enable = true;
    settings = [
      (builtins.fromJSON (builtins.readFile ./waybar-config))
    ]; 
    style = builtins.readFile ./waybar-style;
    systemd = {
      enable = true;
      target = "sway-session.target";
    };
  };

  home.pointerCursor.sway.enable = true;
}
