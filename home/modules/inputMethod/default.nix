{ pkgs, ... }:
{
  home.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [ pkgs.fcitx5-bamboo ];
  };

  systemd.user.services.fcitx5-daemon.Service.Environment = [
    "XMODIFIERS=@im=fcitx"
    "GTK_IM_MODULE=fcitx"
    "QT_IM_MODULES=fcitx"
  ];
}
