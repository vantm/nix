{ username, ... }:
{
  services.wpaperd = {
    enable = true;
    settings.default = {
      path = "/home/${username}/Wallpapers";
      sorting = "random";
      mode = "center";
    };
  };
}
