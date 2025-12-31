{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zsh-vi-mode
    pure-prompt
  ];

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

      ZVM_INIT_MODE=precmd
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
    options = [ "--cmd cd" ];
  };

  programs.fzf = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      notARepository = "skip";
      git = {
        branchLogCmd = "git log --graph --decorate --oneline {{branchName}} --";
        allBranchesLogCmds = [ "git log --graph --decorate --oneline" ];
      };
    };
  };

  programs.fd.enable = true;

  programs.ripgrep.enable = true;

  programs.jq.enable = true;
}

