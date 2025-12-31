{ pkgs, ... }:
{
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme = {
      name = "qt5ct";
      package = pkgs.qt6Packages.qt6ct;
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-icon-theme;
    };
  };
}
