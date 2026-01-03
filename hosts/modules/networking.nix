{ pkgs, hostname, ... }:
{
  networking.hostName = hostname;

  networking.dhcpcd.wait = "background";
  networking.dhcpcd.extraConfig = "noarp";

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;

  networking.nameservers = [
    "94.140.14.14:5353"
    "94.140.15.15:5353"
  ];

  services.resolved = {
    enable = true;
    domains = [ "~." ];
    fallbackDns = [
      "94.140.14.14:5353"
      "94.140.15.15:5353"
    ];
  };

  systemd.network.wait-online.enable = false;
}
