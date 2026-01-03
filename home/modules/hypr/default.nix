{ pkgs, ... }:
{
  wayland.systemd.target = "hyprland-session.target";

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
    };
    settings = {
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
      };

      decoration = {
        rounding = 0;
        active_opacity = 2.0;
        inactive_opacity = 2.0;
        fullscreen_opacity = 2.0;
        blur.enabled = "false";
      };

      group.groupbar = {
        "col.active" = "0xffd4be98";
        "col.inactive" = "0xaa868686";
        text_color = "0xff282828";
        text_color_inactive = "0xff282828";
        gradient_rounding = 0;
        gaps_out = 0;
        gaps_in = 2;
        indicator_gap = 2;
      };

      animations.enabled = "false";

      input = {
        kb_layout = "us";
        kb_options = "compose:caps";
        repeat_rate = 40;
        repeat_delay = 600;
        numlock_by_default = "true";
        sensitivity = 0;
        accel_profile = "flat";
        follow_mouse = 1;

        touchpad = {
          natural_scroll = "true";
          scroll_factor = 0.2;
        };
      };

      "$mod" = "SUPER";
      "$terminal" = "alacritty";
      "$menu" = "pgrep tofi-run && pkill tofi-run || ${pkgs.tofi}/bin/tofi-run --fuzzy-match true | xargs ${pkgs.hyprland}/bin/hyprctl dispatch exec --";

      bind = [
        "ALT, tab, focuscurrentorlast"
        "$mod, tab, workspace, e+1"
        "$mod SHIFT, tab, workspace, e-1"
        "$mod, return, exec, $terminal"
        "$mod, d, exec, $menu"
        "$mod, f, fullscreen"
        "$mod SHIFT, q, killactive"
        "$mod SHIFT, c, centerwindow"
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        "$mod SHIFT, h, swapwindow, l"
        "$mod SHIFT, l, swapwindow, r"
        "$mod SHIFT, k, swapwindow, u"
        "$mod SHIFT, j, swapwindow, d"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod, u, resizeactive, -32 0"
        "$mod, i, resizeactive, 32 0"
        "$mod, o, resizeactive, 0 -18"
        "$mod, p, resizeactive, 0 18"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod SHIFT, mouse:272, resizewindow"
      ];


      gesture = [
        "3, horizontal, workspace"
      ];

      windowrule = [
        "scrolltouchpad 1.5, class:(Alacritty|kitty)"
        "tag +modal, class:DBeaver, title:negative:^DBeaver.*"
        "tag +floating-window, initialClass:java, initialTitle:Dbeaver"
        "tag +modal, class:polkit-gnome-authentication-agent-1"
        "tag +modal, tag +floating-window, class:^xdg-desktop-portal.*"
        "tag +modal, class:^float-tui.*"
        "bordersize 6, bordercolor rgb(076678), pinned:1"
      ];
    };
  };

  home.pointerCursor.hyprcursor.enable = true;

  imports = [
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprlock.nix
  ];
}
