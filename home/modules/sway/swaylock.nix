{ pkgs, ... }:
{
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
}
