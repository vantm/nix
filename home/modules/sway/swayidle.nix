{ pkgs, ... }:
{
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
    events = {
      "before-sleep" = "${pkgs.swaylock-effects}/bin/swaylock -f";
    };
  };
}
