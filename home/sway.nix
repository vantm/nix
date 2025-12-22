{ pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    systemd.enable = true;
    config = {
      output = {
        eDP-1 = {
          mode = "2880x1800@90Hz";
          scale = "1.5";
          background = "/home/vantm/Wallpapers/wallpaper.png fill";
        };
      };
      input = {
        "type:touchpad" = {
          accel_profile = "flat";
          click_method = "clickfinger";
          natural_scroll = "enabled";
          scroll_factor = "0.8";
          tap = "enabled";
          dwt = "enabled";
        };
      };
      fonts = {
        names = [ "0xProto Nerd Font" ];
        size = 10.0;
      };
      modifier = "Mod4";
      terminal = "alacritty";
      bars = [];
    };
    extraConfig = ''
      unbindsym Mod4+d
      set $drun tofi-drun | xargs swaymsg exec --
      bindsym Mod4+d exec $drun

      bindsym Mod4+Control+Mod1+p exec poweroff
      bindsym Mod4+Control+Mod1+l exec swaylock

      bindgesture swipe:left workspace next
      bindgesture swipe:right workspace prev

      bindsym XF86AudioRaiseVolume exec swayosd-client --output-volume raise
      bindsym XF86AudioLowerVolume exec  swayosd-client --output-volume lower
      bindsym XF86AudioMute exec swayosd-client --output-volume mute-toggle

      bindsym XF86AudioMicMute exec swayosd-client --input-volume mute-toggle

      bindsym XF86MonBrightnessUp exec swayosd-client --brightness raise
      bindsym XF86MonBrightnessDown exec swayosd-client --brightness lower

      bindsym --release Caps_Lock exec swayosd-client --caps-lock
    '';
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 180;
        command = "hyprctl dispatch dpms off && swaylock";
        resumeCommand = "hyprctl dispatch dpms on";
      }
    ];
    events = [
      { event = "before-sleep"; command = "swaylock"; }
    ];
  };

  services.cliphist = {
    enable = true;
    systemdTargets = [ "sway-session.target" ];
    clipboardPackage = pkgs.wl-clipboard;
  };

  services.swaync.enable = true;
  services.swayosd.enable = true;

  programs.swaylock = {
    enable = true;
    settings = {
      image = "/home/vantm/Wallpapers/wallpaper.png";
      "indicator-thickness" = 0;
    };
  };

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

  programs.tofi = {
    enable = true;
    settings = {
      anchor = "top";
      width = "100%";
      height = 30;
      horizontal = "true";
      font-size = 10;
      prompt-text = "run: ";
      font = "monospace";
      outline-width = 0;
      border-width = 0;
      background-color = "#000000";
      min-input-width = 120;
      result-spacing = 15;
      padding-top = 0;
      padding-bottom = 0;
      padding-left = 0;
      padding-right = 0;
    };
  };

  home.pointerCursor.sway.enable = true;
}
