{ ... }:
{
  programs.k9s = {
    enable = true;
    settings.k9s = {
      maxConnRetry = 7;
      noExitOnCtrlC = true;
      ui = {
        headless = true;
        logoless = true;
        crumbsless = true;
        noIcons = true;
        skin = "gruvbox-dark-hard";
      };
    };
  };

  programs.zsh.shellAliases.ks = "k9s";

  home.file.".config/k9s/skins/gruvbox-dark-hard.yaml".text =
    builtins.readFile ./gruvbox-dark-hard.yaml;
}
