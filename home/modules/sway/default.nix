{ pkgs, lib, config, ... }:
{
  wayland.systemd.target = "sway-session.target";

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    systemd.enable = true;
    config = {
      output = {
        eDP-1 = { mode = "2880x1800@90Hz"; scale = "1.3333334"; };
      };
      colors.focused = {
        background = "#458588";
        border = "#458588";
        childBorder = "#458588";
        indicator = "#d65d0e";
        text = "#ebdbb2";
      };
      input = {
        "type:pointer" = {
          accel_profile = "flat";
        };
        "type:touchpad" = {
          accel_profile = "flat";
          click_method = "clickfinger";
          natural_scroll = "enabled";
          drag_lock = "disabled";
          tap = "enabled";
        };
      };
      fonts = { names = [ "0xProto Nerd Font" ]; size = 10.0; };
      modifier = "Mod4";
      terminal = "alacritty";
      bars = [ ];
      startup = [
        { command = "sleep 0.5 && ${pkgs.sway}/bin/swaymsg \"workspace 1\""; }
      ];
      menu = "pgrep tofi-run && pkill tofi-run || ${pkgs.tofi}/bin/tofi-run --fuzzy-match true | xargs swaymsg exec --";
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
          floatTerm = "alacritty --class 'float-tui.term'";
        in
        lib.mkOptionDefault {
          "${modifier}+Shift+Return" = "exec ${floatTerm}";

          "${modifier}+c" = "move absolute position center";

          "${modifier}+u" = "resize shrink width 20 px";
          "${modifier}+i" = "resize grow width 20 px";
          "${modifier}+o" = "resize shrink height 20 px";
          "${modifier}+p" = "resize grow height 20 px";

          "${modifier}+Shift+u" = "resize shrink height 20 px; resize shrink width 20 px";
          "${modifier}+Shift+i" = "resize grow height 20 px; resize grow width 20 px";

          "${modifier}+comma" = "exec makoctl dismiss";
          "${modifier}+Shift+comma" = "exec makoctl restore";

          "${modifier}+Mod1+Control+p" = "exec systemctl poweroff";
          "${modifier}+Mod1+Control+r" = "exec systemctl reboot";
          "${modifier}+Mod1+Control+l" = "exec ${pkgs.swaylock-effects}/bin/swaylock";

          "Print" = "exec ${pkgs.grim}/bin/grim - | ${pkgs.satty}/bin/satty -f -";

          "${modifier}+Print" = "exec ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g - - | ${pkgs.satty}/bin/satty -f -";

          "Mod4+Mod1+c" = "exec ${pkgs.slurp}/bin/slurp -p | ${pkgs.grim}/bin/grim -g - -t ppm - | "
            + "${pkgs.imagemagick}/bin/magick - -format '%[pixel:p{0,0}]' txt:- | "
            + "tail -n 1 | cut -d' ' -f4 | tr '[:upper:]' '[:lower:]' | "
            + "${pkgs.wl-clipboard}/bin/wl-copy -n";
        };
    };
    extraConfig = ''
      bindgesture swipe:left workspace next
      bindgesture swipe:right workspace prev

      bindsym --locked XF86AudioRaiseVolume exec swayosd-client --output-volume raise \
          --device="$(${pkgs.pulseaudio}/bin/pactl -f json list short sinks | jq -r 'sort_by(.state) | first | .name')"
      bindsym --locked XF86AudioLowerVolume exec swayosd-client --output-volume lower \
          --device="$(${pkgs.pulseaudio}/bin/pactl -f json list short sinks | jq -r 'sort_by(.state) | first | .name')"
      bindsym --locked XF86AudioMute exec swayosd-client --output-volume mute-toggle \
          --device="$(${pkgs.pulseaudio}/bin/pactl -f json list short sinks | jq -r 'sort_by(.state) | first | .name')"

      bindsym --locked XF86AudioMicMute exec swayosd-client --input-volume mute-toggle

      bindsym --locked XF86MonBrightnessUp exec swayosd-client --brightness raise
      bindsym --locked XF86MonBrightnessDown exec swayosd-client --brightness lower

      bindsym --release Caps_Lock exec swayosd-client --caps-lock

      for_window [app_id="^float-tui"] floating enable; move absolute position center
      for_window [app_id="float-tui.term"] resize set 80 ppt 80 ppt
      for_window [app_id="float-tui.process"] resize set 70 ppt 80 ppt
      for_window [app_id="float-tui.audio"] resize set 600 px 400 px
      for_window [app_id="float-tui.connection"] resize set 800 px 800 px
    '';
  };

  services.swayosd.enable = true;
  services.mako.enable = true;

  home.pointerCursor.sway.enable = true;

  imports = [
    ./swaylock.nix
    ./swayidle.nix
    ./wlsunset.nix
  ];
}
