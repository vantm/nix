{ pkgs, username, ... }:
{
  home.packages = with pkgs; [
    ## tools
    netcat-openbsd
    tree
    unzip
    imagemagick

    ## tui
    impala
    bluetui
    wiremix

    ## qt
    kdePackages.qt6ct

    ## app
    adwaita-icon-theme
    gnome-themes-extra
    wl-clipboard
    wf-recorder
    libnotify
    ffmpeg
    xdg-utils
    slurp
    grim
    xfce.thunar
    brave
    dbeaver-bin
    localsend
    spotify
  ];

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_dark";
      vim_keys = true;
      proc_tree = true;
    };
  };

  programs.fastfetch.enable = true;

  programs.lazysql.enable = true;

  programs.mpv.enable = true;

  programs.imv.enable = true;

  programs.firefox.enable = true;

  programs.satty.enable = true;

  programs.vscode.enable = true;

  programs.obs-studio.enable = true;

  programs.onlyoffice.enable = true;

  services.ollama.enable = true;
}
