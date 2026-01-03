{ config, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = {
        timeout = 1800;
        fit_mode = "cover";
        path = "${config.home.homeDirectory}/Wallpapers";
        splash = false;
      };
    };
  };
}
