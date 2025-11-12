{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  colors = config.lib.stylix.colors;
  fonts = config.stylix.fonts;
  colorBackground = colors.base00;
  colorForeground = colors.base06;
  colorForegroundUrgent = colors.base08;
  fontMono = fonts.monospace.name;
in {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;

    settings = {
      main = {
        reload_style_on_change = true;
        layer = "top";
        position = "top";
        spacing = 0;
        height = 26;

        modules-left = [
          "niri/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "group/tray-expander"
          "bluetooth"
          "network"
          "pulseaudio"
          "cpu"
          "battery"
        ];

        "niri/workspaces" = {
          all-outputs = true;
          "on-click" = "activate";
          format = "{icon}";
          "format-icons" = {
            default = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            active = "󱓻";
          };
        };

        cpu = {
          interval = 5;
          format = "󰍛";
          "on-click" = "alacritty -e btop";
        };

        clock = {
          format = "{:L%A %H:%M}";
          "format-alt" = "{:L%d %B W%V %Y}";
          tooltip = false;
          "on-click-right" = "omarchy-cmd-tzupdate";
        };

        network = {
          "format-icons" = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format = "{icon}";
          "format-wifi" = "{icon}";
          "format-ethernet" = "󰀂";
          "format-disconnected" = "󰤮";
          "tooltip-format-wifi" = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          "tooltip-format-ethernet" = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          "tooltip-format-disconnected" = "Disconnected";
          interval = 3;
          spacing = 1;
          "on-click" = "alacritty -e impala";
        };

        battery = {
          format = "{capacity}% {icon}";
          "format-discharging" = "{icon}";
          "format-charging" = "{icon}";
          "format-plugged" = "";
          "format-icons" = {
            charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
            default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          "format-full" = "󰂅";
          "tooltip-format-discharging" = "{power:>1.0f}W↓ {capacity}%";
          "tooltip-format-charging" = "{power:>1.0f}W↑ {capacity}%";
          interval = 5;
          "on-click" = "omarchy-menu power";
          states = {
            warning = 20;
            critical = 10;
          };
        };

        bluetooth = {
          format = "";
          "format-disabled" = "󰂲";
          "format-connected" = "";
          "tooltip-format" = "Devices connected: {num_connections}";
          "on-click" = "blueberry";
        };

        pulseaudio = {
          format = "{icon}";
          "on-click" = "alacritty -e wiremix";
          "on-click-right" = "pamixer -t";
          "tooltip-format" = "Playing at {volume}%";
          "scroll-step" = 5;
          "format-muted" = "";
          "format-icons" = {
            default = ["" "" ""];
          };
        };

        "group/tray-expander" = {
          orientation = "inherit";
          drawer = {
            "transition-duration" = 600;
            "children-class" = "tray-group-item";
          };
          modules = ["custom/expand-icon" "tray"];
        };

        "custom/expand-icon" = {
          format = " ";
          tooltip = false;
        };

        tray = {
          "icon-size" = 12;
          spacing = 12;
        };
      };
    };
    style = ''

      @define-color background #${colorBackground};
      @define-color foreground #${colorForeground};
      @define-color foregroundUrgent #${colorForegroundUrgent};

      * {
        background-color: @background;
        color: @foreground;

        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: '${fontMono}', monospace;
        font-size: 12px;
      }

      .modules-left {
        margin-left: 8px;
      }

      .modules-right {
        margin-right: 8px;
      }

      .warning, .critical, .urgent {
        color: @foregroundUrgent;
      }

      #workspaces button {
        all: initial;
        padding: 0 5px;
        margin: 0 1.5px;
        min-width: 9px;
      }

      #workspaces button.empty {
        opacity: 0.5;
      }

      #workspaces button.urgent {
        color: red;
      }

      #cpu,
      #battery,
      #pulseaudio,
      #custom-omarchy,
      #custom-screenrecording-indicator,
      #custom-update {
        min-width: 12px;
        margin: 0 7.5px;
      }

      #tray {
        margin-right: 16px;
      }

      #bluetooth {
        margin-right: 17px;
      }

      #network {
        margin-right: 13px;
      }

      #custom-expand-icon {
        margin-right: 20px;
      }

      tooltip {
        padding: 2px;
      }

      #custom-update {
        font-size: 10px;
      }

      #clock {
        margin-left: 8.75px;
      }

      .hidden {
        opacity: 0;
      }

      #custom-screenrecording-indicator {
        min-width: 12px;
        margin-left: 8.75px;
        font-size: 10px;
      }

      #custom-screenrecording-indicator.active {
        color: #a55555;
      }
    '';
  };
}
