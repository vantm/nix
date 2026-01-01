{ ... }:
{
  services.wlsunset = {
    enable = true;
    sunset = "18:00-20:00";
    sunrise = "6:30-7:30";
    temperature.night = 3000;
  };
}
