{ pkgs, lib, ... }:
{
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
