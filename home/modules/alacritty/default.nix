{ pkgs, lib, ... }:
{
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
}
