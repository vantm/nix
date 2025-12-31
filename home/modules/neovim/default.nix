{ pkgs, lib, ... }:
let
  modules = [
    ./options.lua
    ./mapping.lua
    ./lazy.lua
  ];
  plugins = [
    {
      pkg = pkgs.vimPlugins.indent-blankline-nvim;
      config = "require('ibl').setup()";
    }
    {
      pkg = pkgs.vimPlugins.guess-indent-nvim;
      config = "require('guess-indent').setup()";
    }
  ];
in
{
  programs.neovim = {
    enable = true;
    plugins = (map ({ pkg, ... }: pkg) plugins);
    extraLuaConfig =
      let
        moduleConfigs = map builtins.readFile modules;
        pluginConfigs = map ({ config, ... }: config) plugins;
      in
      lib.concatLines (moduleConfigs ++ pluginConfigs);
  };
}
