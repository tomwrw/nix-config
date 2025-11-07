{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;

    settings = {
      main = {
        reload_style_on_change = true;
        layer = "top";
        position = "top";
        spacing = 0;
        height = 28;

        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "pulseaudio"
          "bluetooth"
          "cpu"
          "memory"
        ];

        "niri/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
          };
        };

        "niri/window" = {
          format = "{}";
          max-length = 50;
        };

        clock = {
          interval = 60;
          format = "{:%d-%m-%Y %H:%M}";
        };

        cpu = {
          interval = 5;
          format = "CPU: {usage}%";
        };

        memory = {
          interval = 5;
          format = "MEM: {percentage}%";
        };

        bluetooth = {
          format = "";
          format-disabled = "󰂲";
          format-connected = "";
          tooltip-format = "Devices connected: {num_connections}";
          on-click = "blueberry";
        };

        pulseaudio = {
          format = "{icon}";
          on-click = "alacritty -e wiremix";
          on-click-right = "pamixer -t";
          tooltip-format = "Playing at {volume}%";
          scroll-step = 5;
          format-muted = "";
          format-icons = {
            default = ["" "" ""];
          };
        };
      };
    };
    style = with config.lib.stylix.colors.withHashtag; ''
      * {
        border: none;
        border-radius: 0;
        font-family: '${config.stylix.fonts.monospace.name}', monospace;
        font-size: 12px;
        min-height: 0;
      }

      window#waybar {
        background: ${base00};
        color: ${base05};
      }

      #workspaces {
        background: ${base01};
      }
      #workspaces button {
        padding: 0 8px;
      }

      #workspaces button.active {
        background: ${base0D};
        color: ${base00};
      }

      #workspaces button.visible {

      }

      #workspaces button.urgent {
        background: ${base08};
        color: ${base07};
      }

      #workspaces button.empty {
        background: ${base02};
        color: ${base05};
      }

      #workspaces button.persistent {

      }

      #workspaces button.hidden {

      }

      #window {
        margin-left: 10px;
      }

      #cpu,
      #memory,
      #bluetooth,
      #pulseaudio {
        padding: 0 8px;
        background: ${base0D};
        color: ${base00};
      }
    '';
  };
}
