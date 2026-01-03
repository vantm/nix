{ pkgs, username, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  services.greetd = {
    enable = true;
    settings = {
      terminal.vt = 1;
      initial_session = {
        user = username;
        command = "sway";
      };
      default_session = {
        user = username;
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
      };
    };
  };

  programs.zsh.enable = true;
}
