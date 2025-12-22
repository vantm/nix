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
          scale = "1.25";
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

      bindsym Mod4+c move absolute position center

      bindsym Mod4+u resize shrink width 10 px
      bindsym Mod4+i resize grow width 10 px
      bindsym Mod4+o resize shrink height 10 px
      bindsym Mod4+p resize grow height 10 px

      bindsym Mod4+Shift+u \
        resize shrink height 10 px, resize shrink width 10 px
      bindsym Mod4+Shift+i \
        resize grow width 10 px, resize grow heigth 10 px

      bindsym Mod4+Control+Mod1+p exec systemctl poweroff
      bindsym Mod4+Control+Mod1+l exec ${pkgs.swaylock-effects}/bin/swaylock

      bindgesture swipe:left workspace next
      bindgesture swipe:right workspace prev

      bindsym --locked XF86AudioRaiseVolume exec swayosd-client --output-volume raise
      bindsym --locked XF86AudioLowerVolume exec  swayosd-client --output-volume lower
      bindsym --locked XF86AudioMute exec swayosd-client --output-volume mute-toggle

      bindsym --locked XF86AudioMicMute exec swayosd-client --input-volume mute-toggle

      bindsym --locked XF86MonBrightnessUp exec swayosd-client --brightness raise
      bindsym --locked XF86MonBrightnessDown exec swayosd-client --brightness lower

      bindsym --release Caps_Lock exec swayosd-client --caps-lock
    '';
  };

  services.swayidle = {
    enable = true;
    systemdTarget = "sway-session.target";
    timeouts = [
      { timeout = 30; command = "${pkgs.swaylock-effects}/bin/swaylock"; }
      {
        timeout = 60;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
      { timeout = 1800; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -f"; }
    ];
  };

  services.cliphist = {
    enable = true;
    clipboardPackage = pkgs.wl-clipboard;
    systemdTargets = [ "sway-session.target" ];
  };

  services.swayosd.enable = true;
  services.mako.enable = true;

  services.wlsunset = {
    enable = true;
    systemdTarget = "sway-session.target";
    sunset = "18:00-20:00";
    sunrise = "5:30-7:00";
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      ignore-empty-password = true;
      daemonize = true;
      indicator = true;
      clock = true;
      datestr = "%d/%m/%Y";
      screenshots = true;
      show-keyboard-layout = true;
      indicator-caps-lock = true;
      bs-hl-color = "7daea3cc";
      caps-lock-bs-hl-color = "7daea3cc";
      caps-lock-key-hl-color = "d3869bcc";
      font = "JetBrains Mono";
      font-size = 35;
      indicator-idle-visible = true;
      indicator-radius = 100;
      indicator-thickness = 7;
      inside-color = "32302f66";
      inside-clear-color = "89b48266";
      inside-caps-lock-color = "e78a4e66";
      inside-ver-color = "7daea366";
      inside-wrong-color = "ea696266";
      key-hl-color = "a9b665cc";
      layout-bg-color = "32302f00";
      layout-text-color = "d4be98";
      line-color = "00000000";
      ring-color = "e78a4ecc";
      ring-clear-color = "89b482cc";
      ring-caps-lock-color = "e78a4ecc";
      ring-ver-color = "7daea3cc";
      ring-wrong-color = "ea6962cc";
      separator-color = "00000000";
      text-color = "d4be98";
      text-clear-color = "d4be98";
      text-caps-lock-color = "d4be98";
      text-ver-color = "d4be98";
      text-wrong-color = "d4be98";
      effect-blur = "10x5";
      effect-greyscale = true;
      effect-vignette = "0.5:0.5";
    };
  };

  programs.waybar = {
    enable = true;
    settings = [
      (builtins.fromJSON (builtins.readFile ./waybar-config))
    ]; 
    style = builtins.readFile ./waybar-style;
    systemd.enable = true;
    systemd.target = "sway-session.target";
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
