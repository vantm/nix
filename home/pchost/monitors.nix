{ ... }:
let
  secondary = "DP-1";
  primary = "HDMI-A-1";
in
{
  wayland.windowManager.sway.config = {
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
}
