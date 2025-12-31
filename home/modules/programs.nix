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

  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "Van Tran";
      user.email = "tmvan.1903@gmail.com";
      init.defaultBranch = "master";
      core.editor = "nvim";
      pull.ff = "only";
      merge.conflictStyle = "zdiff3";
    };
  };

  programs.lazysql.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_dark";
      vim_keys = true;
      proc_tree = true;
    };
  };

  programs.mpv.enable = true;

  programs.imv.enable = true;

  programs.fastfetch.enable = true;

  programs.satty.enable = true;

  programs.vscode.enable = true;

  programs.obs-studio.enable = true;

  programs.onlyoffice.enable = true;

  services.ollama.enable = true;

  services.wpaperd = {
    enable = true;
    settings.default = {
      path = "/home/${username}/Wallpapers";
      duration = "1d";
      sorting = "random";
      mode = "center";
    };
  };
}
