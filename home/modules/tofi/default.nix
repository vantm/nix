{ ... }:
{
  programs.tofi = {
    enable = true;
    settings = {
      # Layout
      anchor = "bottom";
      horizontal = "true";
      width = "100%";
      height = 40;

      # Font
      font = "0xProto Nerd Font";
      font-size = 12;

      # Window
      outline-width = 0;
      border-width = 0;
      min-input-width = 120;
      result-spacing = 30;
      padding-top = 8;
      padding-bottom = 0;
      padding-left = 20;
      padding-right = 0;
      clip-to-padding = "false";

      # Prompt
      prompt-text = "run: ";
      prompt-padding = 30;
      prompt-background = "#1a1a1a";
      prompt-background-padding = "4, 10";
      prompt-background-corner-radius = 4;

      # Colors (dark theme)
      background-color = "#000000";
      text-color = "#cdd6f4";

      input-color = "#f38ba8";
      input-background = "#181825";
      input-background-padding = "4, 10";
      input-background-corner-radius = 4;

      alternate-result-background = "#11111b";
      alternate-result-background-padding = "4, 10";
      alternate-result-background-corner-radius = 4;

      selection-color = "#ffffff";
      selection-match-color = "#ffffff";
      selection-background = "#313244";
      selection-background-padding = "4, 10";
      selection-background-corner-radius = 4;
    };
  };
}
