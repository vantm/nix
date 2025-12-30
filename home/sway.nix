{ pkgs, lib, config, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    systemd.enable = true;
    config = {
      output = {
        eDP-1 = { mode = "2880x1800@90Hz"; scale = "1.3333334"; };
      };
      input = {
        "type:pointer" = {
          accel_profile = "flat";
        };
        "type:touchpad" = {
          accel_profile = "flat";
          click_method = "clickfinger";
          natural_scroll = "enabled";
          scroll_factor = "0.8";
          drag_lock = "disabled";
          tap = "enabled";
          dwt = "enabled";
        };
      };
      fonts = { names = [ "0xProto Nerd Font" ]; size = 10.0; };
      modifier = "Mod4";
      terminal = "alacritty";
      bars = [];
      startup = [
        { command = "sleep 0.5 && ${pkgs.sway}/bin/swaymsg \"workspace 1\""; }
      ];
      menu = "pgrep tofi-run && pkill tofi-run || ${pkgs.tofi}/bin/tofi-run --fuzzy-match true | xargs swaymsg exec --";
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+c" = "move absolute position center";

        "${modifier}+u" = "resize shrink width 5 ppt";
        "${modifier}+i" = "resize grow width 5 ppt";
        "${modifier}+o" = "resize shrink height 5 ppt";
        "${modifier}+p" = "resize grow height 5 ppt";

        "${modifier}+Shift+u" = "resize shrink height 5 ppt; resize shrink width 5 ppt";
        "${modifier}+Shift+i" = "resize grow height 5 ppt; resize grow width 5 ppt";

        "${modifier}+comma" = "exec makoctl dismiss";
        "${modifier}+Shift+comma" = "exec makoctl restore";

        "${modifier}+Mod1+Control+p" = "exec systemctl poweroff";
        "${modifier}+Mod1+Control+r" = "exec systemctl reboot";
        "${modifier}+Mod1+Control+l" = "exec ${pkgs.swaylock-effects}/bin/swaylock";

        "Print" = "exec ${pkgs.grim}/bin/grim - | ${pkgs.satty}/bin/satty -f -";

        "${modifier}+Print" = "exec ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g - - | ${pkgs.satty}/bin/satty -f -";

        "Mod4+Mod1+c" = "exec ${pkgs.slurp}/bin/slurp -p | ${pkgs.grim}/bin/grim -g - -t ppm - | "
            + "${pkgs.imagemagick}/bin/magick - -format '%[pixel:p{0,0}]' txt:- | "
            + "tail -n 1 | cut -d' ' -f4 | ${pkgs.wl-clipboard}/bin/wl-copy";
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
      for_window [app_id="float-tui.process"] resize set 70 ppt 80 ppt
      for_window [app_id="float-tui.audio"] resize set 600 px 400 px
      for_window [app_id="float-tui.connection"] resize set 800 px 800 px
    '';
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 120; command = "${pkgs.swaylock-effects}/bin/swaylock"; }
      {
        timeout = 180;
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
  };

  services.swayosd.enable = true;
  services.mako.enable = true;

  services.wlsunset = {
    enable = true;
    sunset = "18:00-20:00";
    sunrise = "6:30-7:30";
    temperature.night = 3000;
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
      font = "0xProto Nerd Font";
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

  programs.tofi = {
    enable = true;
    settings = {
      # Layout
      anchor = "bottom";
      horizontal = "true";
      width = "100%";
      height = 40;
  
      # Font
      font = "0xProto Nerd Font";
      font-size = 12;
  
      # Window
      outline-width = 0;
      border-width = 0;
      min-input-width = 120;
      result-spacing = 30;
      padding-top = 8;
      padding-bottom = 0;
      padding-left = 20;
      padding-right = 0;
      clip-to-padding = "false";
  
      # Prompt
      prompt-text = "run: ";
      prompt-padding = 30;
      prompt-background = "#1a1a1a";
      prompt-background-padding = "4, 10";
      prompt-background-corner-radius = 4;
  
      # Colors (dark theme)
      background-color = "#000000";
      text-color = "#cdd6f4";
  
      input-color = "#f38ba8";
      input-background = "#181825";
      input-background-padding = "4, 10";
      input-background-corner-radius = 4;
  
      alternate-result-background = "#11111b";
      alternate-result-background-padding = "4, 10";
      alternate-result-background-corner-radius = 4;
  
      selection-color = "#ffffff";
      selection-match-color = "#ffffff";
      selection-background = "#313244";
      selection-background-padding = "4, 10";
      selection-background-corner-radius = 4;
    };
  };

  home.pointerCursor.sway.enable = true;

  imports = [ ./waybar.nix ];
}
