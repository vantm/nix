{ ... }:
{
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  systemd.user.services.docker.wants = [ "sway-session.target" ];
  systemd.user.services.docker.after = [ "sway-session.target" ];
}
