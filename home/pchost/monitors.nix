{ lib, config, ... }:
let
  secondary = "DP-1";
  primary = "HDMI-A-1";
  windowManager = config.wayland.windowManager;
in
{
  wayland.windowManager.sway.config = lib.mkIf windowManager.sway.enable {
    output = {
      ${secondary} = { mode = "2560x1440@60Hz"; scale = "1.3333334"; pos = "-2560 360"; };
      ${primary} = { mode = "3840x2160@60Hz"; scale = "1.75"; };
    };

    workspaceOutputAssign = [
      { workspace = "1"; output = secondary; }
      { workspace = "2"; output = secondary; }
      { workspace = "3"; output = primary; }
      { workspace = "4"; output = primary; }
      { workspace = "5"; output = primary; }
      { workspace = "6"; output = primary; }
      { workspace = "7"; output = primary; }
      { workspace = "8"; output = primary; }
      { workspace = "9"; output = primary; }
      { workspace = "10"; output = primary; }
    ];
  };

  home.sessionVariables = lib.mkIf windowManager.hyprland.enable {
    GDK_SCALE = "1.75";
  };

  wayland.windowManager.hyprland.settings = lib.mkIf windowManager.hyprland.enable {
    monitor = [
      "${secondary},2560x1440@60,0x0,1.333334"
      "${primary},3840x2160@60,1920x-50,1.6"
    ];

    workspace = [
      "1, monitor:${secondary}"
      "2, monitor:${secondary}"
      "3, monitor:${primary}"
      "4, monitor:${primary}"
      "5, monitor:${primary}"
      "6, monitor:${primary}"
      "7, monitor:${primary}"
      "8, monitor:${primary}"
      "9, monitor:${primary}"
      "10, monitor:${primary}"
    ];
  };
}
