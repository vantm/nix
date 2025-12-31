{ pkgs, lib, ... }:
{
  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
  };

  programs.git.settings = {
    core.editor = "nvim";
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = lazy-nvim;
        config = builtins.readFile ./lazy.lua;
        type = "lua";
      }
    ];
    extraLuaConfig =
      let
        configs = map builtins.readFile [ ./options.lua ./mapping.lua ];
      in
      lib.concatLines configs;
  };
}
