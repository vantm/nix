{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 30;
        "margin-bottom" = 0;
        "margin-top" = 0;
        "modules-left" = [ "sway/mode" "sway/workspaces" ];
        "modules-center" = [ "clock" "idle_inhibitor" "privacy" ];
        "modules-right" = [
          "sway/scratchpad" 
          "cpu"
          "memory"
          "network"
          "bluetooth"
          "backlight"
          "wireplumber"
          "battery"
          "tray"
        ];
        "sway/mode" = { };
        "sway/scratchpad" = { "format-icons" = [ "󰹕" ]; };
        "sway/workspaces" = { };
        tray = { "icon-size" = 20; spacing = 4; };
        clock = {
          format = "{:%a, %b %d, %Y - %R}";
          "tooltip-format" = "\n<span size='12pt' font='monospace' background='#000'>{calendar}</span>";
          calendar = {
            mode = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "left";
            "on-scroll" = 1;
            format = {
              months   = "<span color='#e05634'>{}</span>";
              days     = "<span>{}</span>";
              weeks    = "<span color='#62c1cc'>W{}</span>";
              weekdays = "<span color='#62c1cc'>{}</span>";
              today    = "<span color='#e05634'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            "on-click-right" = "mode";
            "on-click" = "shift_reset";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };
        cpu = {
          interval = 5;
          format = " {}%";
          "on-click" = "${pkgs.alacritty}/bin/alacritty --class 'float-tui.process' --command ${pkgs.btop}/bin/btop";
        };
        memory = {
          interval = 10;
          format = " {used:0.1f}GB";
          warning = 70;
          critical = 90;
        };
        network = {
          interval = 5;
          "format-wifi" = " {essid}";
          "format-ethernet" = " ";
          "format-linked" = "{ipaddr}";
          "format-disconnected" = "󰪎";
          "format-disabled" = "";
          "tooltip-format" = "{ipaddr}/{cidr}";
          "max-length" = 12;
          "on-click" = "${pkgs.alacritty}/bin/alacritty --class 'float-tui.connection' --command ${pkgs.impala}/bin/impala";
        };
        wireplumber = {
          format = "{icon} {volume}%";
          "format-icons" = [ "" ];
          "format-muted" = "<span color='#EE4E4E'> </span>";
          "on-click" = "${pkgs.alacritty}/bin/alacritty --class 'float-tui.audio' --command ${pkgs.wiremix}/bin/wiremix";
          "on-click-right" = "${pkgs.alacritty}/bin/alacritty --class 'float-tui.audio' --command ${pkgs.wiremix}/bin/wiremix -v output";
          "on-scroll-up" = "${pkgs.swayosd}/bin/swayosd-client --output-volume +1 > /dev/null";
          "on-scroll-down" = "${pkgs.swayosd}/bin/swayosd-client --output-volume -1  > /dev/null";
          "scroll-step" = 1;
        };
        bluetooth = {
          format = " {status}";
          "format-disabled" = "";
          "format-connected" = "{device_alias}";
          "tooltip-format" = "{controller_alias}\t{controller_address}";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          "on-click" = "${pkgs.alacritty}/bin/alacritty --class 'float-tui.connection' --command ${pkgs.bluetui}/bin/bluetui";
        };
        backlight = {
          format = "{icon} {percent}%";
          "format-icons" = [ "󰌶" "󱩏" "󱩑" "󱩓" "󱩕" "󰛨" ];
          "on-scroll-up" = "${pkgs.swayosd}/bin/swayosd-client --brightness raise > /dev/null";
          "on-scroll-down" = "${pkgs.swayosd}/bin/swayosd-client --brightness lower > /dev/null";
          "scroll-step" = 0.1;
        };
        battery = {
          bat = "BAT1";
          interval = 60;
          states = { warning = 30; critical = 15; };
          format = "{icon}{capacity}%";
          "format-icons" = [ "󰂃" "󰁻" "󰁽" "󰁿" "󰂁" "󱟢" ];
        };

        idle_inhibitor = {
          format = "{icon}";
          "format-icons" = { activated = "󰈈"; deactivated = "󰈉"; };
          "icon-size" = 32;
        };

        privacy = {
          "icon-spacing" = 4;
          "icon-size" = 20;
          "transition-duration" = 250;
          modules = [
            { type = "screenshare"; tooltip = true; "tooltip-icon-size" = 24; }
            { type = "audio-out";   tooltip = true; "tooltip-icon-size" = 24; }
            { type = "audio-in";    tooltip = true; "tooltip-icon-size" = 24; }
          ];
        };
      }
    ]; 
    style = builtins.readFile ./styles.css;
    systemd.enable = true;
  };
}
