{ ... }:
{
  home.file.".config/hypr/hyprlock.conf".text = ''
    # BACKGROUND
    background {
      monitor =
      path = screenshot
      blur_passes = 2
    }

    # GENERAL
    general {
      no_fade_in = false
      grace = 0
      disable_loading_bar = false
    }

    animations {
      enabled = yes
    }

    label {
      monitor =
      text = cmd[update:10000] echo -e "$(date +"%A, %B %d, %Y")"
      color = rgba(216, 222, 233, 0.70)
      font_size = 26
      font_family = 0xProto Nerd Font
      position = 0, 160
      halign = center
      valign = center
    }

    # Time
    label {
      monitor =
      text = cmd[update:10000] echo "<span>$(date +"%R")</span>"
      color = rgba(216, 222, 233, 0.70)
      font_size = 180
      font_family = 0xProto Nerd Font
      position = 0, 0
      halign = center
      valign = center
    }

    # USER
    label {
      monitor =
      text =  $USER
      color = rgba(216, 222, 233, 0.80)
      font_family = 0xProto Nerd Font
      font_size = 32
      position = 0, -300
      halign = center
      valign = center
    }

    # INPUT FIELD
    input-field {
      monitor =
      size = 300, 60
      outline_thickness = 0
      dots_size = 0.3 # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.4 # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = true
      outer_color = rgba(0, 0, 0, 0.1)
      inner_color = rgba(255, 255, 255, 0.2)
      font_color = rgb(200, 200, 200)
      fade_on_empty = false
      font_family = 0xProto Nerd Font
      font_size = 32
      placeholder_text = password
      hide_input = false
      position = 0, -380
      rounding = 3
      halign = center
      valign = center
    }
  '';
}
