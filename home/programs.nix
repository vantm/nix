{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ## zsh plugins
    zsh-vi-mode
    pure-prompt

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
    bibata-cursors
    gnome-themes-extra
    wl-clipboard
    wf-recorder
    libnotify
    ffmpeg
    xdg-utils
    slurp
    grim
    kdePackages.dolphin
    brave
    dbeaver-bin
    localsend
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

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      k = "kubectl";
      ".." = "cd ..";
      "..." = "cd ../..";
    };

    history.size = 10000;

    initContent = ''
      fpath+=($HOME/.config/pure)
      autoload -Uz prompinit; promptinit
      prompt pure

      unsetopt BEEP
    '';

    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      notARepository = "skip";
      git = {
        branchLogCmd = "git log --graph --decorate --oneline {{branchName}} --";
        allBranchesLogCmds = [ "git log --graph --decorate --oneline" ];
      };
    };
  };

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

  programs.fd.enable = true;

  programs.ripgrep.enable = true;

  programs.jq.enable = true;

  programs.alacritty = {
    enable = true;
    theme = "gruvbox_material_hard_dark";
    settings = {
      font = {
        normal = { family = "0xProto Nerd Font"; style = "Regular"; };
        bold = { family = "0xProto Nerd Font"; style = "Bold"; };
        italic = { family = "0xProto Nerd Font"; style = "Italic"; };
        size = 12;
      };

      window = {
        padding = { x = 4; y = 4; };
        # decorations = "None";
      };

      keyboard.bindings = [
      	{ key = "Insert"; mods = "Shift"; action = "Paste"; }
      	{ key = "Insert"; mods = "Control"; action = "Copy"; }
      	{ mode = "Vi"; key = "O"; mods = "Shift"; action = "Open"; }
      	{ mode = "Vi"; key = "Q"; action = "ToggleViMode"; }
      	{ mode = "Vi"; key = "U"; action = "ScrollHalfPageUp"; }
      	{ mode = "Vi"; key = "D"; action = "ScrollHalfPageDown"; }
      ];

      cursor.vi_mode_style.shape = "Block";
    };
  };

  programs.satty.enable = true;

  programs.vscode.enable = true;

  programs.obs-studio.enable = true;

  programs.onlyoffice.enable = true;

  services.ollama.enable = true;

  services.wpaperd = {
    enable = true;
    settings.default = {
      path = "/home/vantm/Wallpapers";
      duration = "1d";
      sorting = "random";
      mode = "center";
    };
  };

  imports = [ ./neovim.nix ];
}
