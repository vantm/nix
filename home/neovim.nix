{ pkgs, ... }:
{
  home.packages = with pkgs; [ gcc ];

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ lazy-nvim ];
    extraConfig = ''
      set nu rnu
      set nowrap
      set bri udf ic scs
      set cul cc=80,120
      set ut=500
      set si ai 
      set sw=2 et
    '';
    extraLuaConfig = builtins.readFile ./neovim-lazy;
  };
}
